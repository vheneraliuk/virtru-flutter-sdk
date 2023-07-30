import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk_flutter/common/client.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/client.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';

abstract class Client {
  factory Client.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl.withAppId(
        userId: userId,
        appId: appId,
      );

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

  int setConsoleLoggingLevel(LogLevel level);

  int setZipProtocol(bool enableZip);

  Future<String> encryptString(EncryptStringParams params);

  Future<String> encryptStringToRCA(EncryptStringParams params);

  Future<XFile> encryptFile(EncryptFileToFileParams params);

  Future<String> encryptFileToRCA(EncryptFileToRcaParams params);

  Future<XFile> decryptFile(XFile inputFile, XFile outputFile);

  Future<String> decryptString(String tdf3);

  Future<String> decryptRcaToString(String rcaLink);

  Future<XFile> decryptRcaToFile(String rcaLink, XFile outputFile);

  void dispose();
}

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
