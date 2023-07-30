import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk_flutter/common/client.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/client.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/native_error.dart';

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

  /// Enable the internal logger class to write logs to the console for given [LogLevel].
  int setConsoleLoggingLevel(LogLevel level);

  /// Set the TDF protocol (format) to be used for encryption and decryption operations. HTML is the
  /// default format.  The protocols refer to the data format after encryption.
  int setZipProtocol(bool enableZip);

  /// Encrypt the plain data into a TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<String> encryptString(EncryptStringParams params);

  /// Encrypt the plain data into a remote TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<String> encryptStringToRCA(EncryptStringParams params);

  /// Encrypt the contents of the input file into a TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<XFile> encryptFile(EncryptFileToFileParams params);

  /// Encrypt the contents of the input file into a RCA TDF.
  ///
  /// Throws an [NativeError] in case of failure.
  Future<String> encryptFileToRCA(EncryptFileToRcaParams params);

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
