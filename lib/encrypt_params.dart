import 'dart:io';

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
  factory EncryptFileParams.fromFiles(File inputFile, File outputFile) {
    return EncryptFileParamsImpl.fromFiles(inputFile, outputFile);
  }

  factory EncryptFileParams.fromFile(File inputFile) {
    return EncryptFileParamsImpl.fromFile(inputFile);
  }

  setPolicy(Policy policy);

  setDisplayName(String name);

  setDisplayMessage(String message);

  setMimeType(String mimeType);

  shareWithUsers(List<String> usersEmail);
}
