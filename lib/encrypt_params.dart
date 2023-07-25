import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

class EncryptStringParams {
  final VEncryptStringParamsPtr ptr;

  factory EncryptStringParams(String data) {
    return EncryptStringParams._(bindings.VEncryptStringParamsCreate(
        data.toNativeUtf8().cast(), data.length));
  }

  EncryptStringParams._(this.ptr);

  setPolicy(Policy policy) {
    bindings.VEncryptStringParamsSetPolicy(ptr, policy.ptr);
  }

  setDisplayName(String name) {
    bindings.VEncryptStringParamsSetDisplayName(
        ptr, name.toNativeUtf8().cast());
  }

  setDisplayMessage(String message) {
    bindings.VEncryptStringParamsSetDisplayMessage(
        ptr, message.toNativeUtf8().cast());
  }

  setMimeType(String mimeType) {
    bindings.VEncryptStringParamsSetMimeType(
        ptr, mimeType.toNativeUtf8().cast());
  }

  shareWithUsers(List<String> usersEmail) {
    final usersPtrList =
    usersEmail.map((user) => user.toNativeUtf8().cast<Char>()).toList();
    final Pointer<Pointer<Char>> usersPtr =
    calloc.allocate(usersPtrList.length);
    for (int i = 0; i < usersPtrList.length; i++) {
      usersPtr[i] = usersPtrList[i];
    }
    bindings.VEncryptStringParamsShareWithUsers(
        ptr, usersPtr, usersPtrList.length);
  }
}

class EncryptFileParams {
  final VEncryptFileParamsPtr ptr;

  factory EncryptFileParams.fromFiles(File inputFile, File outputFile) {
    return EncryptFileParams._(bindings.VEncryptFileParamsCreate2(
        inputFile.path.toNativeUtf8().cast(),
        outputFile.path.toNativeUtf8().cast()));
  }

  factory EncryptFileParams.fromFile(File inputFile) {
    return EncryptFileParams._(bindings.VEncryptFileParamsCreate1(
        inputFile.path.toNativeUtf8().cast()));
  }

  EncryptFileParams._(this.ptr);

  setPolicy(Policy policy) {
    bindings.VEncryptFileParamsSetPolicy(ptr, policy.ptr);
  }

  setDisplayName(String name) {
    bindings.VEncryptFileParamsSetDisplayName(ptr, name.toNativeUtf8().cast());
  }

  setDisplayMessage(String message) {
    bindings.VEncryptFileParamsSetDisplayMessage(
        ptr, message.toNativeUtf8().cast());
  }

  setMimeType(String mimeType) {
    bindings.VEncryptFileParamsSetMimeType(ptr, mimeType.toNativeUtf8().cast());
  }

  shareWithUsers(List<String> usersEmail) {
    final usersPtrList =
    usersEmail.map((user) => user.toNativeUtf8().cast<Char>()).toList();
    final Pointer<Pointer<Char>> usersPtr =
    calloc.allocate(usersPtrList.length);
    for (int i = 0; i < usersPtrList.length; i++) {
      usersPtr[i] = usersPtrList[i];
    }
    bindings.VEncryptFileParamsShareWithUsers(
        ptr, usersPtr, usersPtrList.length);
  }
}
