import 'dart:io';

import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/policy.dart';

class EncryptStringParamsImpl implements EncryptStringParams {
  factory EncryptStringParamsImpl(String data) {
    return EncryptStringParamsImpl._();
  }

  EncryptStringParamsImpl._();

  @override
  setDisplayMessage(String message) {
    // TODO: implement setDisplayMessage
    throw UnimplementedError();
  }

  @override
  setDisplayName(String name) {
    // TODO: implement setDisplayName
    throw UnimplementedError();
  }

  @override
  setMimeType(String mimeType) {
    // TODO: implement setMimeType
    throw UnimplementedError();
  }

  @override
  setPolicy(Policy policy) {
    // TODO: implement setPolicy
    throw UnimplementedError();
  }

  @override
  shareWithUsers(List<String> usersEmail) {
    // TODO: implement shareWithUsers
    throw UnimplementedError();
  }
}

class EncryptFileParamsImpl implements EncryptFileParams {
  factory EncryptFileParamsImpl.fromFiles(File inputFile, File outputFile) {
    return EncryptFileParamsImpl._();
  }

  factory EncryptFileParamsImpl.fromFile(File inputFile) {
    return EncryptFileParamsImpl._();
  }

  EncryptFileParamsImpl._();

  @override
  setDisplayMessage(String message) {
    // TODO: implement setDisplayMessage
    throw UnimplementedError();
  }

  @override
  setDisplayName(String name) {
    // TODO: implement setDisplayName
    throw UnimplementedError();
  }

  @override
  setMimeType(String mimeType) {
    // TODO: implement setMimeType
    throw UnimplementedError();
  }

  @override
  setPolicy(Policy policy) {
    // TODO: implement setPolicy
    throw UnimplementedError();
  }

  @override
  shareWithUsers(List<String> usersEmail) {
    // TODO: implement shareWithUsers
    throw UnimplementedError();
  }
}