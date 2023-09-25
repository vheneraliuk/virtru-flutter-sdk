import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk/client.dart';
import 'package:virtru_sdk/encrypt_params.dart';
import 'package:virtru_sdk/entity/metadata.dart';
import 'package:virtru_sdk/entity/security_settings.dart';
import 'package:virtru_sdk/policy.dart';

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
  Future<String> decryptString(String tdf3) {
    // TODO: implement decryptString
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
  setEnvironment(Environment env) {
    // TODO: implement setEnvironment
    throw UnimplementedError();
  }

  @override
  int setConsoleLoggingLevel(LogLevel level) {
    // TODO: implement setConsoleLoggingLevel
    throw UnimplementedError();
  }

  @override
  Future<Encrypted<XFile>> encryptFile(EncryptFileToFileParams params) {
    // TODO: implement encryptFile
    throw UnimplementedError();
  }

  @override
  Future<Encrypted<String>> encryptFileToRCA(EncryptFileToRcaParams params) {
    // TODO: implement encryptFileToRCA
    throw UnimplementedError();
  }

  @override
  Future<Encrypted<String>> encryptString(EncryptStringParams params) {
    // TODO: implement encryptString
    throw UnimplementedError();
  }

  @override
  Future<Encrypted<String>> encryptStringToRCA(EncryptStringParams params) {
    // TODO: implement encryptStringToRCA
    throw UnimplementedError();
  }

  @override
  Future<Policy> fetchPolicyById(String uuid) {
    // TODO: implement fetchPolicyById
    throw UnimplementedError();
  }

  @override
  int setZipProtocol(bool enableZip) {
    // TODO: implement setZipProtocol
    throw UnimplementedError();
  }

  @override
  setOfflineMode(bool enabled) {
    // TODO: implement setOfflineMode
    throw UnimplementedError();
  }

  @override
  Future<void> revokeFile(XFile tdfFile) {
    // TODO: implement revokeFile
    throw UnimplementedError();
  }

  @override
  Future<void> revokePolicy(String uuid) {
    // TODO: implement revokePolicy
    throw UnimplementedError();
  }

  @override
  Future<void> updatePolicyForFile(Policy policy, XFile tdfFile) {
    // TODO: implement updatePolicyForFile
    throw UnimplementedError();
  }

  @override
  Future<void> updatePolicyForId(Policy policy, String uuid) {
    // TODO: implement updatePolicyForId
    throw UnimplementedError();
  }

  @override
  Future<String> generateSecureShareLink(
    List<SecureShareMetadata> metadataObjects,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String openMessage = '',
    String encryptedMessage = '',
  }) {
    // TODO: implement generateSecureShareLink
    throw UnimplementedError();
  }

  @override
  Future<String> secureShareData(
    List<XFile> files,
    List<String> shareWith, {
    SecuritySettings? securitySettings,
    String openMessage = '',
    String encryptedMessage = '',
  }) {
    // TODO: implement secureShareData
    throw UnimplementedError();
  }

  @override
  dispose() {
    // TODO: implement dispose
  }
}
