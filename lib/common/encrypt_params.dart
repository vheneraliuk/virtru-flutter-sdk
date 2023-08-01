import 'dart:ffi';

import 'package:cross_file/cross_file.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk/common/policy.dart';
import 'package:virtru_sdk/encrypt_params.dart';
import 'package:virtru_sdk/policy.dart';
import 'package:virtru_sdk/virtru_sdk_bindings.dart';
import 'package:virtru_sdk/virtru_sdk_bindings_generated.dart';

class EncryptStringParamsImpl implements EncryptStringParams {
  final VEncryptStringParamsPtr ptr;
  VPolicyPtr? policyPtr;

  factory EncryptStringParamsImpl(String data) {
    return EncryptStringParamsImpl._(bindings.VEncryptStringParamsCreate(
        data.toNativeUtf8().cast(), data.length));
  }

  EncryptStringParamsImpl._(this.ptr);

  @override
  setPolicy(Policy policy) {
    policyPtr = policy.ptr;
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

class EncryptFileParamsImpl
    implements EncryptFileToRcaParams, EncryptFileToFileParams {
  final VEncryptFileParamsPtr ptr;
  VPolicyPtr? policyPtr;
  final String _outputFilePath;

  factory EncryptFileParamsImpl.fileToFile(XFile inputFile, XFile outputFile) {
    return EncryptFileParamsImpl._(
      bindings.VEncryptFileParamsCreate2(inputFile.path.toNativeUtf8().cast(),
          outputFile.path.toNativeUtf8().cast()),
      outputFile.path,
    );
  }

  factory EncryptFileParamsImpl.fileToRca(XFile inputFile) {
    return EncryptFileParamsImpl._(
      bindings.VEncryptFileParamsCreate1(inputFile.path.toNativeUtf8().cast()),
      "",
    );
  }

  EncryptFileParamsImpl._(this.ptr, this._outputFilePath);

  @override
  setPolicy(Policy policy) {
    policyPtr = policy.ptr;
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

  @override
  String get outputFilePath => _outputFilePath;
}

extension on Policy {
  VPolicyPtr get ptr => (this as PolicyImpl).ptr;
}
