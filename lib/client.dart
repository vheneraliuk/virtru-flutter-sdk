import 'dart:async';
import 'dart:io';

import 'package:virtru_sdk_flutter/common/client.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/client.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';

// import 'common/client.dart' if (dart.library.html) 'web/client.dart';

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

  int enableConsoleLogging();

  int setZipProtocol(bool enableZip);

  Future<String> encryptString(EncryptStringParams params);

  Future<String> encryptStringToRCA(EncryptStringParams params);

  Future<String> encryptFile(EncryptFileParams params);

  Future<String> encryptFileToRCA(EncryptFileParams params);

  Future<int> decryptFile(File inputFile, File outputFile);

  Future<String> decryptRcaToString(String rcaLink);

  Future<int> decryptRcaToFile(String rcaLink, String outputFile);

  void dispose();
}
