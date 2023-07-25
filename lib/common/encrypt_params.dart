import 'dart:ffi';

import 'package:cross_file/cross_file.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/common/policy.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

class EncryptStringParamsImpl implements EncryptStringParams {
  final VEncryptStringParamsPtr ptr;

  factory EncryptStringParamsImpl(String data) {
    return EncryptStringParamsImpl._(bindings.VEncryptStringParamsCreate(
        data.toNativeUtf8().cast(), data.length));
  }

  EncryptStringParamsImpl._(this.ptr);

  @override
  setPolicy(Policy policy) {
    bindings.VEncryptStringParamsSetPolicy(ptr, policy.ptr);
  }

  @override
  setDisplayName(String name) {
    bindings.VEncryptStringParamsSetDisplayName(
        ptr, name.toNativeUtf8().cast());
  }

  @override
  setDisplayMessage(String message) {
    bindings.VEncryptStringParamsSetDisplayMessage(
        ptr, message.toNativeUtf8().cast());
  }

  @override
  setMimeType(String mimeType) {
    bindings.VEncryptStringParamsSetMimeType(
        ptr, mimeType.toNativeUtf8().cast());
  }

  @override
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

class EncryptFileParamsImpl implements EncryptFileParams {
  final VEncryptFileParamsPtr ptr;

  factory EncryptFileParamsImpl.fromFiles(XFile inputFile, XFile outputFile) {
    return EncryptFileParamsImpl._(bindings.VEncryptFileParamsCreate2(
        inputFile.path.toNativeUtf8().cast(),
        outputFile.path.toNativeUtf8().cast()));
  }

  factory EncryptFileParamsImpl.fromFile(XFile inputFile) {
    return EncryptFileParamsImpl._(bindings.VEncryptFileParamsCreate1(
        inputFile.path.toNativeUtf8().cast()));
  }

  EncryptFileParamsImpl._(this.ptr);

  @override
  setPolicy(Policy policy) {
    bindings.VEncryptFileParamsSetPolicy(ptr, policy.ptr);
  }

  @override
  setDisplayName(String name) {
    bindings.VEncryptFileParamsSetDisplayName(ptr, name.toNativeUtf8().cast());
  }

  @override
  setDisplayMessage(String message) {
    bindings.VEncryptFileParamsSetDisplayMessage(
        ptr, message.toNativeUtf8().cast());
  }

  @override
  setMimeType(String mimeType) {
    bindings.VEncryptFileParamsSetMimeType(ptr, mimeType.toNativeUtf8().cast());
  }

  @override
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

extension on Policy {
  VPolicyPtr get ptr => (this as PolicyImpl).ptr;
}
