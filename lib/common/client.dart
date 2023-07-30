import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:cross_file/cross_file.dart';
import 'package:easy_isolate/easy_isolate.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/client.dart';
import 'package:virtru_sdk_flutter/common/encrypt_params.dart';
import 'package:virtru_sdk_flutter/common/policy.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/native_error.dart';
import 'package:virtru_sdk_flutter/policy.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

part 'client_helper.dart';

class ClientImpl implements Client {
  final VClientPtr _clientPtr;

  factory ClientImpl.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl._(
        bindings.VClientCreateWithAppId(
          userId.toNativeUtf8().cast(),
          appId.toNativeUtf8().cast(),
        ),
      );

  factory ClientImpl.withOIDC({
    required String owner,
    required String organizationName,
    required String clientId,
    required String clientSecret,
  }) =>
      ClientImpl._(
        bindings.VClientCreateWithOIDC(
          owner.toNativeUtf8().cast(),
          organizationName.toNativeUtf8().cast(),
          clientId.toNativeUtf8().cast(),
          clientSecret.toNativeUtf8().cast(),
        ),
      );

  ClientImpl._(this._clientPtr);

  @override
  int setConsoleLoggingLevel(LogLevel level) {
    return bindings.VEnableConsoleLogging(_clientPtr, level.logLevel);
  }

  @override
  int setZipProtocol(bool enableZip) {
    return bindings.VSetProtocol(_clientPtr,
        enableZip ? VProtocol.VProtocolZip : VProtocol.VProtocolHtml);
  }

  @override
  Future<Encrypted<String>> encryptString(EncryptStringParams params) async {
    return _encryptString(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  @override
  Future<Encrypted<String>> encryptStringToRCA(
      EncryptStringParams params) async {
    return _encryptStringToRCA(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  @override
  Future<Encrypted<XFile>> encryptFile(EncryptFileToFileParams params) async {
    final policyId =
        await _encryptFile(_EncryptFileRequest(_clientPtr, params.ptr));
    return Encrypted(policyId, XFile(params.outputFilePath));
  }

  @override
  Future<Encrypted<String>> encryptFileToRCA(EncryptFileParams params) async {
    return _encryptFileToRCA(_EncryptFileRequest(_clientPtr, params.ptr));
  }

  @override
  Future<XFile> decryptFile(XFile inputFile, XFile outputFile) async {
    await _decryptFile(_DecryptFileRequest(
      _clientPtr,
      inputFile.path,
      outputFile.path,
    ));
    return XFile(outputFile.path);
  }

  @override
  Future<String> decryptString(String tdf3) {
    return _decryptString(_DecryptStringRequest(_clientPtr, tdf3));
  }

  @override
  Future<String> decryptRcaToString(String rcaLink) async {
    return _decryptRcaToString(_DecryptRcaRequest(
      _clientPtr,
      rcaLink,
    ));
  }

  @override
  Future<XFile> decryptRcaToFile(String rcaLink, XFile outputFile) async {
    await _decryptRcaToFile(_DecryptRcaToFileRequest(
      _clientPtr,
      rcaLink,
      outputFile.path,
    ));
    return XFile(outputFile.path);
  }

  @override
  Future<Policy> fetchPolicyById(String uuid) async {
    final policyPtrAddress =
        await _fetchPolicyId(_FetchPolicyIdRequest(_clientPtr, uuid));
    return PolicyImpl.fromPtr(VPolicyPtr.fromAddress(policyPtrAddress));
  }

  @override
  dispose() {
    bindings.VClientDestroy(_clientPtr);
  }
}

extension on EncryptStringParams {
  VEncryptStringParamsPtr get ptr => (this as EncryptStringParamsImpl).ptr;
}

extension on EncryptFileParams {
  VEncryptFileParamsPtr get ptr => (this as EncryptFileParamsImpl).ptr;
}
