import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk/common/client.dart'
    if (dart.library.html) 'package:virtru_sdk/web/client.dart';
import 'package:virtru_sdk/encrypt_params.dart';
import 'package:virtru_sdk/entity/metadata.dart';
import 'package:virtru_sdk/entity/native_error.dart';
import 'package:virtru_sdk/entity/secure_share_result.dart';
import 'package:virtru_sdk/entity/security_settings.dart';
import 'package:virtru_sdk/policy.dart';

abstract class Client {
  /// Create a new Virtru Client instance with [userId] and [appId].
  @Deprecated("Use Client.withOIDC() instead")
  factory Client.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl.withAppId(
        userId: userId,
        appId: appId,
      );

  /// Create a new Virtru Client instance with [owner] and organization/realm-scoped OIDC client credentials.
  factory Client.withOIDC({
    required String owner,
    required String organizationName,
    required String clientId,
    required String clientSecret,
  }) =>
      ClientImpl.withOIDC(
        owner: owner,
        organizationName: organizationName,
        clientId: clientId,
        clientSecret: clientSecret,
      );

  /// Set the environment for the client.
  setEnvironment(Environment env);

  /// Enable the internal logger class to write logs to the console for given [LogLevel].
  int setConsoleLoggingLevel(LogLevel level);

  /// Set the TDF protocol (format) to be used for encryption and decryption operations. HTML is the
  /// default format.  The protocols refer to the data format after encryption.
  int setZipProtocol(bool enableZip);

  /// Encrypt the plain data into a TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<Encrypted<String>> encryptString(EncryptStringParams params);

  /// Encrypt the plain data into a remote TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<Encrypted<String>> encryptStringToRCA(EncryptStringParams params);

  /// Encrypt the contents of the input file into a TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<Encrypted<XFile>> encryptFile(EncryptFileToFileParams params);

  /// Encrypt the contents of the input file into a RCA TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<Encrypted<String>> encryptFileToRCA(EncryptFileToRcaParams params);

  /// Decrypt the contents of the TDF file into its original content.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<XFile> decryptFile(XFile inputFile, XFile outputFile);

  /// Decrypt the TDF data.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<String> decryptString(String tdf3);

  /// Decrypt the remote content TDF (RCA).
  ///
  /// Throws an [NativeError] in case of failure.
  Future<String> decryptRcaToString(String rcaLink);

  /// Decrypt the remote contents (RCA) file into its original content.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<XFile> decryptRcaToFile(String rcaLink, XFile outputFile);

  /// Return the policy associated with the given policy [uuid].
  Future<Policy> fetchPolicyById(String uuid);

  /// Update the policy for a given TDF file using its policy [uuid].
  Future<void> updatePolicyForId(Policy policy, String uuid);

  /// Update the policy for a given [tdfFile].
  Future<void> updatePolicyForFile(Policy policy, XFile tdfFile);

  /// Revoke access for all the share users of the tdf file using the policy [uuid].
  Future<void> revokePolicy(String uuid);

  /// Revoke access for all the share users of the [tdfFile].
  Future<void> revokeFile(XFile tdfFile);

  /// Generate a secure share link for the given [metadataObjects] and [shareWith] users.
  /// The [securitySettings] is the optional security settings for the secure share.
  /// The [openMessage] is the optional open message to be sent to the share users.
  /// The [encryptedMessage] is the optional encrypted message to be sent to the share users.
  Future<String> generateSecureShareLink(
    List<SecureShareMetadata> metadataObjects,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String openMessage = '',
    String encryptedMessage = '',
  });

  /// Securely share the given [files] with the [shareWith] users.
  /// The [securitySettings] is the optional security settings for the secure share.
  /// The [openMessage] is the optional open message to be sent to the share users.
  /// The [encryptedMessage] is the optional encrypted message to be sent to the share users.
  /// Returns the secure share link.
  Future<String> secureShareData(
    List<XFile> files,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String openMessage = '',
    String encryptedMessage = '',
  });

  /// Decrypt given [secureShareUrl].
  Future<SecureShareResult> decryptSecureShareLink(String secureShareUrl);

  /// Set the offline mode.
  /// If [enabled], all the TDFs will be encrypted in offline mode that means the symmetric key
  /// stored part of the TDF instead on the server.
  setOfflineMode(bool enabled);

  /// Dispose the Virtru Client instance.
  dispose();
}

/// [LogLevel] for console logging.
enum LogLevel {
  trace(0),
  debug(1),
  info(2),
  warn(3),
  error(4),
  fatal(5);

  final int logLevel;

  const LogLevel(this.logLevel);
}

enum Environment {
  prod(
      kasEndpoint: 'https://api.virtru.com/kas',
      easEndpoint: 'https://api.virtru.com/accounts',
      acmEndpoint: 'https://api.virtru.com/acm',
      readerUrl: 'https://secure.virtru.com/start',
      secureShareUrl: 'https://secure.virtru.com/secure-share',
      rcaEndpoint: 'https://api.virtru.com/rca',
      storageEndpoint: 'https://api.virtru.com/encrypted-storage',
      fileStreamServiceWorker:
          'https://secure.virtru.com/rca/stream-saver/index.html'),
  staging(
      kasEndpoint: 'https://api.staging.virtru.com/kas',
      easEndpoint: 'https://api.staging.virtru.com/accounts',
      acmEndpoint: 'https://api.staging.virtru.com/acm',
      readerUrl: 'https://secure.staging.virtru.com/start',
      secureShareUrl: 'https://secure.staging.virtru.com/secure-share',
      rcaEndpoint: 'https://api.staging.virtru.com/rca',
      storageEndpoint: 'https://api.staging.virtru.com/encrypted-storage',
      fileStreamServiceWorker:
          'https://secure.staging.virtru.com/rca/stream-saver/index.html'),
  dev(
      kasEndpoint: 'https://api.develop.virtru.com/kas',
      easEndpoint: 'https://api.develop.virtru.com/accounts',
      acmEndpoint: 'https://api.develop.virtru.com/acm',
      readerUrl: 'https://secure.develop.virtru.com/start',
      secureShareUrl: "https://secure.develop.virtru.com/secure-share",
      rcaEndpoint: 'https://api.develop.virtru.com/rca',
      storageEndpoint: 'https://api.develop.virtru.com/encrypted-storage',
      fileStreamServiceWorker:
          'https://secure.develop.virtru.com/rca/stream-saver/index.html');

  const Environment(
      {required this.kasEndpoint,
      required this.easEndpoint,
      required this.acmEndpoint,
      required this.readerUrl,
      required this.secureShareUrl,
      required this.rcaEndpoint,
      required this.storageEndpoint,
      required this.fileStreamServiceWorker});

  final String kasEndpoint;
  final String easEndpoint;
  final String acmEndpoint;
  final String readerUrl;
  final String secureShareUrl;
  final String rcaEndpoint;
  final String storageEndpoint;
  final String fileStreamServiceWorker;
}

///Result of encrypt operation
class Encrypted<Res> {
  ///Policy Uuid related to encrypted data
  final String policyId;

  ///Encrypted data/file or RCA Link
  final Res result;

  Encrypted(this.policyId, this.result);
}
