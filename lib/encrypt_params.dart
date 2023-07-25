import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk_flutter/common/encrypt_params.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/encrypt_params.dart';
import 'package:virtru_sdk_flutter/policy.dart';

abstract class EncryptStringParams {
  factory EncryptStringParams(String data) {
    return EncryptStringParamsImpl(data);
  }

  setPolicy(Policy policy);

  setDisplayName(String name);

  setDisplayMessage(String message);

  setMimeType(String mimeType);

  shareWithUsers(List<String> usersEmail);
}

abstract class EncryptFileParams {
  factory EncryptFileParams.fromFiles(XFile inputFile, XFile outputFile) {
    return EncryptFileParamsImpl.fromFiles(inputFile, outputFile);
  }

  factory EncryptFileParams.fromFile(XFile inputFile) {
    return EncryptFileParamsImpl.fromFile(inputFile);
  }

  setPolicy(Policy policy);

  setDisplayName(String name);

  setDisplayMessage(String message);

  setMimeType(String mimeType);

  shareWithUsers(List<String> usersEmail);
}
