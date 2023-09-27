import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:virtru_sdk/client.dart';
import 'package:virtru_sdk/common/api/auth_interceptor.dart';
import 'package:virtru_sdk/common/api/entity/api_entities.dart';

part 'acm_client.g.dart';

@RestApi(baseUrl: "https://api.virtru.com/acm")
abstract class AcmClient {
  final String _owner;
  final Environment _env;

  AcmClient._(this._owner, this._env);

  factory AcmClient(String userId, String appId, Environment env) {
    final dio = Dio()..interceptors.addAll(_getInterceptors(userId, appId));
    return _AcmClient._(dio, userId, env, baseUrl: env.acmEndpoint);
  }

  Future<CreateResult> createCollectionPolicy(
    List<String> childrenPolicyIds,
    List<String> sharedWithUsers, {
    DateTime? expirationDate,
  }) async {
    var timestamp = DateTime.timestamp();
    var policy = <String, dynamic>{
      'type': 'collection',
      'owner': _owner,
      'displayName': 'PP-${timestamp.toIso8601String()}',
      'sentFrom': _owner,
      'simplePolicy': {
        // Email users must be an array and should not include the owner
        'emailUsers': sharedWithUsers.where((user) => user != _owner).toList(),
        'state': 'active',
      },
      'clientInfo': {},
      'children': childrenPolicyIds,
      'associatedAttachmentIds': [],
      'fileProvider': 'drive',
      'key': timestamp.millisecondsSinceEpoch.toString(),
    };
    if (expirationDate != null) {
      policy['simplePolicy']['activeEnd'] =
          expirationDate.toUtc().toIso8601String();
    }
    return _createCollectionPolicy(policy);
  }

  Future<void> sendEmailsOnFilesSharing(
    String policyId,
    List<String> sharedWithUsers,
    List<String> fileNames,
    String ek, {
    String openMessage = '',
  }) async {
    final templateData = {
      'filesOwner': _owner,
      'message': openMessage,
      'filesList':
          fileNames.map((fileName) => ({'fileName': fileName})).toList(),
      'uuid': policyId,
      'ek': ek,
    };
    final sendEmailUrl = "${_env.easEndpoint}/api/send-transaction";
    for (final shareWithUser in sharedWithUsers) {
      final sharedWithEmailData = {
        'recipients': [shareWithUser],
        'templateId': 'SS_ON_FILE_SHARING_TO_RECIPIENT',
        'templateData': templateData,
      };
      await sendEmail(sendEmailUrl, sharedWithEmailData);
    }

    final ownerEmailData = {
      'recipients': [_owner],
      'templateId': 'SS_ON_FILE_SHARING_TO_FILE_OWNER',
      'templateData': templateData..addAll({'linkOwner': sharedWithUsers}),
    };
    await sendEmail(sendEmailUrl, ownerEmailData);
  }

  @POST('{url}')
  Future<void> sendEmail(
    @Path('url') String url,
    @Body() Map<String, dynamic> data, {
    @Header('Content-Type') String contentType = 'application/json',
    @Header('Origin') String origin = 'https://secure.virtru.com',
    @Header('Referer') String referer = 'https://secure.virtru.com/',
  });

  @POST("/api/policies")
  Future<CreateResult> _createCollectionPolicy(
    @Body() Map<String, dynamic> policy, {
    @Header('Content-Type') String contentType = 'application/json',
  });

  @PUT("{url}")
  Future<void> uploadMetadata(
    @Path('url') String url,
    @Body() String metadataBase64, {
    @Header('Content-Type') String contentType = 'text/plain',
    @Header('Ignore-Auth') String ignoreAuth = 'true',
  });

  @GET("/api/policies/{policyId}/data/metadata")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getMetadata(@Path() String policyId);

  static List<Interceptor> _getInterceptors(String userId, String appId) {
    return <Interceptor>[AuthInterceptor(userId, appId)];
  }
}
