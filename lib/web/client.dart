import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk_flutter/client.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';

class ClientImpl implements Client {
  factory ClientImpl.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl._();

  factory ClientImpl.withOIDC({
    required String owner,
    required String organizationName,
    required String clientId,
    required String clientSecret,
  }) =>
      ClientImpl._();

  ClientImpl._();

  @override
  Future<XFile> decryptFile(XFile inputFile, XFile outputFile) {
    // TODO: implement decryptFile
    throw UnimplementedError();
  }

  @override
  Future<XFile> decryptRcaToFile(String rcaLink, XFile outputFile) {
    // TODO: implement decryptRcaToFile
    throw UnimplementedError();
  }

  @override
  Future<String> decryptRcaToString(String rcaLink) {
    // TODO: implement decryptRcaToString
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  int enableConsoleLogging() {
    // TODO: implement enableConsoleLogging
    throw UnimplementedError();
  }

  @override
  Future<XFile> encryptFile(EncryptFileToFileParams params) {
    // TODO: implement encryptFile
    throw UnimplementedError();
  }

  @override
  Future<String> encryptFileToRCA(EncryptFileToRcaParams params) {
    // TODO: implement encryptFileToRCA
    throw UnimplementedError();
  }

  @override
  Future<String> encryptString(EncryptStringParams params) {
    // TODO: implement encryptString
    throw UnimplementedError();
  }

  @override
  Future<String> encryptStringToRCA(EncryptStringParams params) {
    // TODO: implement encryptStringToRCA
    throw UnimplementedError();
  }

  @override
  int setZipProtocol(bool enableZip) {
    // TODO: implement setZipProtocol
    throw UnimplementedError();
  }
}
