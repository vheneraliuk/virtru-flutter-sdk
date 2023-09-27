import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';

import 'package:cross_file/cross_file.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:easy_isolate/easy_isolate.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk/client.dart';
import 'package:virtru_sdk/common/api/acm_client.dart';
import 'package:virtru_sdk/common/encrypt_params.dart';
import 'package:virtru_sdk/common/policy.dart';
import 'package:virtru_sdk/encrypt_params.dart';
import 'package:virtru_sdk/entity/metadata.dart';
import 'package:virtru_sdk/entity/native_error.dart';
import 'package:virtru_sdk/entity/secure_share_link.dart';
import 'package:virtru_sdk/entity/secure_share_result.dart';
import 'package:virtru_sdk/entity/security_settings.dart';
import 'package:virtru_sdk/policy.dart';
import 'package:virtru_sdk/virtru_sdk_bindings.dart';
import 'package:virtru_sdk/virtru_sdk_bindings_generated.dart';

part 'client_helper.dart';

class ClientImpl implements Client {
  final VClientPtr _clientPtr;
  final String _owner;
  final String _appId;
  Environment _env = Environment.prod;

  factory ClientImpl.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl._(
        bindings.VClientCreateWithAppId(
          userId.toNativeString(),
          appId.toNativeString(),
        ),
        userId,
        appId,
      );

  factory ClientImpl.withOIDC({
    required String owner,
    required String organizationName,
    required String clientId,
    required String clientSecret,
  }) =>
      ClientImpl._(
        bindings.VClientCreateWithOIDC(
          owner.toNativeString(),
          organizationName.toNativeString(),
          clientId.toNativeString(),
          clientSecret.toNativeString(),
        ),
        owner,
        "",
      );

  ClientImpl._(this._clientPtr, this._owner, this._appId);

  @override
  setEnvironment(Environment env) {
    bindings.VClientSetKasUrl(_clientPtr, env.kasEndpoint.toNativeString());
    bindings.VClientSetEasUrl(_clientPtr, env.easEndpoint.toNativeString());
    bindings.VClientSetAcmUrl(_clientPtr, env.acmEndpoint.toNativeString());
    bindings.VClientSetSecureReaderUrl(
        _clientPtr, env.readerUrl.toNativeString());
    bindings.VClientSetEncryptedStorageURL(
        _clientPtr, env.storageEndpoint.toNativeString());
    bindings.VClientSetRCAServiceURL(
        _clientPtr, env.rcaEndpoint.toNativeString());
    _env = env;
  }

  @override
  int setConsoleLoggingLevel(LogLevel level) {
    return bindings.VEnableConsoleLogging(_clientPtr, level.logLevel);
  }

  @override
  int setZipProtocol(bool enableZip) {
    return bindings.VSetProtocol(_clientPtr,
        enableZip ? VProtocol.VProtocolZip : VProtocol.VProtocolHtml);
  }

  @override
  Future<Encrypted<String>> encryptString(EncryptStringParams params) async {
    final result =
        await _encryptString(_EncryptStringRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
  }

  @override
  Future<Encrypted<String>> encryptStringToRCA(
      EncryptStringParams params) async {
    final result = await _encryptStringToRCA(
        _EncryptStringRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
  }

  @override
  Future<Encrypted<XFile>> encryptFile(EncryptFileToFileParams params) async {
    final policyId =
        await _encryptFile(_EncryptFileRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return Encrypted(policyId, XFile(params.outputFilePath));
  }

  @override
  Future<Encrypted<String>> encryptFileToRCA(
      EncryptFileToRcaParams params) async {
    final result =
        await _encryptFileToRCA(_EncryptFileRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
  }

  @override
  Future<XFile> decryptFile(XFile inputFile, XFile outputFile) async {
    await _decryptFile(_DecryptFileRequest(
      _clientPtr,
      inputFile.path,
      outputFile.path,
    ));
    return XFile(outputFile.path);
  }

  @override
  Future<String> decryptString(String tdf3) {
    return _decryptString(_DecryptStringRequest(_clientPtr, tdf3));
  }

  @override
  Future<String> decryptRcaToString(String rcaLink) async {
    return _decryptRcaToString(_DecryptRcaRequest(
      _clientPtr,
      rcaLink,
    ));
  }

  @override
  Future<XFile> decryptRcaToFile(String rcaLink, XFile outputFile) async {
    await _decryptRcaToFile(_DecryptRcaToFileRequest(
      _clientPtr,
      rcaLink,
      outputFile.path,
    ));
    return XFile(outputFile.path);
  }

  @override
  Future<Policy> fetchPolicyById(String uuid) async {
    final policyPtrAddress =
        await _fetchPolicyById(_FetchPolicyByIdRequest(_clientPtr, uuid));
    return PolicyImpl.fromPtr(VPolicyPtr.fromAddress(policyPtrAddress));
  }

  @override
  Future<void> updatePolicyForId(Policy policy, String uuid) async {
    await _updatePolicyForId(
        _UpdatePolicyForIdRequest(_clientPtr, policy.ptr, uuid));
  }

  @override
  Future<void> updatePolicyForFile(Policy policy, XFile tdfFile) async {
    await _updatePolicyForFile(
        _UpdatePolicyForFileRequest(_clientPtr, policy.ptr, tdfFile.path));
  }

  @override
  Future<void> revokePolicy(String uuid) async {
    await _revokePolicy(_RevokePolicyRequest(_clientPtr, uuid));
  }

  @override
  Future<void> revokeFile(XFile tdfFile) async {
    await _revokeFile(_RevokeFileRequest(_clientPtr, tdfFile.path));
  }

  @override
  setOfflineMode(bool enabled) {
    bindings.VSetOffline(_clientPtr, enabled ? 1 : 0);
  }

  @override
  Future<String> generateSecureShareLink(
    List<SecureShareMetadata> metadataObjects,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String encryptedMessage = '',
    String openMessage = '',
  }) async {
    if (_appId.isEmpty) {
      throw NativeError(1, 'Secure Share is not supported for OIDC users yet.');
    }
    final filesMetadata = Map<String, dynamic>.fromEntries(
      metadataObjects.map((object) => MapEntry(
            object.policyId,
            {
              'name': object.name,
              'size': object.size,
              'rcaLink': object.rcaLink,
            },
          )),
    );
    final childrenPolicyIds = metadataObjects.map((e) => e.policyId).toList();
    final metadata = {
      'files': filesMetadata,
      'filesOwner': _owner,
      'messages': {
        'encrypted': encryptedMessage,
        'opening': openMessage,
      },
    };
    final apiClient = AcmClient(_owner, _appId, _env);
    final createResult = await apiClient.createCollectionPolicy(
      childrenPolicyIds,
      shareWith,
      expirationDate: securitySettings?.expirationDate,
    );
    final metadataJson = jsonEncode(metadata);
    final (encryptedMetadata, secretKey) = await _encryptMetadata(metadataJson);
    await apiClient.uploadMetadata(
        createResult.metadataUploadUrl, base64Encode(encryptedMetadata));

    final urlEncodedMetadataKey = Uri.encodeComponent(base64Encode(secretKey));

    await apiClient.sendEmailsOnFilesSharing(
      createResult.uuid,
      shareWith,
      metadataObjects.map((e) => e.name).toList(),
      urlEncodedMetadataKey,
      openMessage: openMessage,
    );

    return SecureShareLink.create(_env, _owner, createResult.uuid, secretKey);
  }

  @override
  Future<String> secureShareData(
    List<XFile> files,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String openMessage = '',
    String encryptedMessage = '',
  }) async {
    if (_appId.isEmpty) {
      throw NativeError(1, 'Secure Share is not supported for OIDC users yet.');
    }

    final filesMetadata = <SecureShareMetadata>[];
    for (var file in files) {
      final encryptResult = await encryptFileToRCA(
        EncryptFileToRcaParams(file)
          ..setDisplayName(file.name)
          ..setPolicy(
            Policy()
              ..setPersistentProtectionEnabled(
                securitySettings?.isPersistentProtected ?? false,
              )
              ..setWatermarkEnabled(
                securitySettings?.isWatermarkEnabled ?? false,
              ),
          ),
      );
      final fileSize = await file.length();
      filesMetadata.add(SecureShareMetadata(
        policyId: encryptResult.policyId,
        name: file.name,
        size: fileSize,
        rcaLink: encryptResult.result,
      ));
    }
    return generateSecureShareLink(
      filesMetadata,
      shareWith,
      securitySettings: securitySettings,
      openMessage: openMessage,
      encryptedMessage: encryptedMessage,
    );
  }

  @override
  Future<SecureShareResult> decryptSecureShareLink(
      String secureShareUrl) async {
    final secureShareLink = SecureShareLink.parse(secureShareUrl);
    if (secureShareLink == null) {
      throw NativeError(1, "Secure Share URL parse error");
    }
    final apiClient = AcmClient(_owner, _appId, _env);
    final metadataBinary =
        await apiClient.getMetadata(secureShareLink.policyUuid);
    final metadataDecoded = base64Decode(String.fromCharCodes(metadataBinary));
    final cipher = FlutterAesGcm.with256bits();
    final secretBoxForMetadata = SecretBox.fromConcatenation(metadataDecoded,
        nonceLength: 12, macLength: 16);
    final metadata = await cipher.decryptString(secretBoxForMetadata,
        secretKey: SecretKey(base64Decode(secureShareLink.metadataKey)));
    final secureShareResult = SecureShareResult.fromMetadata(metadata);
    if (secureShareResult == null) {
      throw NativeError(1, "Secure Share metadata parse error");
    }
    return secureShareResult;
  }

  @override
  dispose() {
    bindings.VClientDestroy(_clientPtr);
  }

  void _disposePolicy(VPolicyPtr? policyPtr) {
    if (policyPtr == null) return;
    bindings.VPolicyDestroy(policyPtr);
  }

  _encryptMetadata(String metadataJson) async {
    final cipher = FlutterAesGcm.with256bits();
    final secretKey = await cipher.newSecretKey();
    final encryptedData =
        await cipher.encryptString(metadataJson, secretKey: secretKey);
    return (encryptedData.concatenation(), await secretKey.extractBytes());
  }
}

extension on EncryptStringParams {
  VEncryptStringParamsPtr get ptr => (this as EncryptStringParamsImpl).ptr;

  VPolicyPtr? get policyPtr => (this as EncryptStringParamsImpl).policyPtr;
}

extension on EncryptFileParams {
  VEncryptFileParamsPtr get ptr => (this as EncryptFileParamsImpl).ptr;

  VPolicyPtr? get policyPtr => (this as EncryptFileParamsImpl).policyPtr;
}

extension on Policy {
  VPolicyPtr get ptr => (this as PolicyImpl).ptr;
}
