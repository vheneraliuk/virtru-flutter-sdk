import 'dart:ffi';

import 'package:cross_file/cross_file.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk/common/client.dart';
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
        data.toNativeString(), data.length));
  }

  EncryptStringParamsImpl._(this.ptr);

  @override
  setPolicy(Policy policy) {
    policyPtr = policy.ptr;
    bindings.VEncryptStringParamsSetPolicy(ptr, policy.ptr);
  }

  @override
  setDisplayName(String name) {
    bindings.VEncryptStringParamsSetDisplayName(ptr, name.toNativeString());
  }

  @override
  setDisplayMessage(String message) {
    bindings.VEncryptStringParamsSetDisplayMessage(
        ptr, message.toNativeString());
  }

  @override
  setMimeType(String mimeType) {
    bindings.VEncryptStringParamsSetMimeType(ptr, mimeType.toNativeString());
  }

  @override
  shareWithUsers(List<String> usersEmail) {
    bindings.VEncryptStringParamsShareWithUsers(
        ptr, usersEmail.toNativeList(), usersEmail.length);
  }
}

class EncryptFileParamsImpl
    implements EncryptFileToRcaParams, EncryptFileToFileParams {
  final VEncryptFileParamsPtr ptr;
  VPolicyPtr? policyPtr;
  final String _outputFilePath;

  factory EncryptFileParamsImpl.fileToFile(XFile inputFile, XFile outputFile) {
    return EncryptFileParamsImpl._(
      bindings.VEncryptFileParamsCreate2(
          inputFile.path.toNativeString(), outputFile.path.toNativeString()),
      outputFile.path,
    );
  }

  factory EncryptFileParamsImpl.fileToRca(XFile inputFile) {
    return EncryptFileParamsImpl._(
      bindings.VEncryptFileParamsCreate1(inputFile.path.toNativeString()),
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
    bindings.VEncryptFileParamsSetDisplayName(ptr, name.toNativeString());
  }

  @override
  setDisplayMessage(String message) {
    bindings.VEncryptFileParamsSetDisplayMessage(ptr, message.toNativeString());
  }

  @override
  setMimeType(String mimeType) {
    bindings.VEncryptFileParamsSetMimeType(ptr, mimeType.toNativeString());
  }

  @override
  shareWithUsers(List<String> usersEmail) {
    bindings.VEncryptFileParamsShareWithUsers(
        ptr, usersEmail.toNativeList(), usersEmail.length);
  }

  @override
  String get outputFilePath => _outputFilePath;
}

extension on Policy {
  VPolicyPtr get ptr => (this as PolicyImpl).ptr;
}

extension NativeConverter on List<String> {
  Pointer<Pointer<Char>> toNativeList() {
    final nativePtrList = map((user) => user.toNativeString()).toList();
    final Pointer<Pointer<Char>> nativePtr =
        calloc.allocate(nativePtrList.length);
    for (int i = 0; i < nativePtrList.length; i++) {
      nativePtr[i] = nativePtrList[i];
    }
    return nativePtr;
  }
}
