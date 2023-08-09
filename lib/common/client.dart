import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:cross_file/cross_file.dart';
import 'package:easy_isolate/easy_isolate.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk/client.dart';
import 'package:virtru_sdk/common/encrypt_params.dart';
import 'package:virtru_sdk/common/policy.dart';
import 'package:virtru_sdk/encrypt_params.dart';
import 'package:virtru_sdk/native_error.dart';
import 'package:virtru_sdk/policy.dart';
import 'package:virtru_sdk/virtru_sdk_bindings.dart';
import 'package:virtru_sdk/virtru_sdk_bindings_generated.dart';

part 'client_helper.dart';

class ClientImpl implements Client {
  final VClientPtr _clientPtr;

  factory ClientImpl.withAppId({
    required String userId,
    required String appId,
  }) =>
      ClientImpl._(
        bindings.VClientCreateWithAppId(
          userId.toNativeString(),
          appId.toNativeString(),
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
          owner.toNativeString(),
          organizationName.toNativeString(),
          clientId.toNativeString(),
          clientSecret.toNativeString(),
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
    final result =
        await _encryptString(_EncryptStringRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
  }

  @override
  Future<Encrypted<String>> encryptStringToRCA(
      EncryptStringParams params) async {
    final result = await _encryptStringToRCA(
        _EncryptStringRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
  }

  @override
  Future<Encrypted<XFile>> encryptFile(EncryptFileToFileParams params) async {
    final policyId =
        await _encryptFile(_EncryptFileRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return Encrypted(policyId, XFile(params.outputFilePath));
  }

  @override
  Future<Encrypted<String>> encryptFileToRCA(
      EncryptFileToRcaParams params) async {
    final result =
        await _encryptFileToRCA(_EncryptFileRequest(_clientPtr, params.ptr));
    _disposePolicy(params.policyPtr);
    return result;
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
        await _fetchPolicyById(_FetchPolicyByIdRequest(_clientPtr, uuid));
    return PolicyImpl.fromPtr(VPolicyPtr.fromAddress(policyPtrAddress));
  }

  @override
  Future<void> updatePolicyForId(Policy policy, String uuid) async {
    await _updatePolicyForId(
        _UpdatePolicyForIdRequest(_clientPtr, policy.ptr, uuid));
  }

  @override
  Future<void> updatePolicyForFile(Policy policy, XFile tdfFile) async {
    await _updatePolicyForFile(
        _UpdatePolicyForFileRequest(_clientPtr, policy.ptr, tdfFile.path));
  }

  @override
  Future<void> revokePolicy(String uuid) async {
    await _revokePolicy(_RevokePolicyRequest(_clientPtr, uuid));
  }

  @override
  Future<void> revokeFile(XFile tdfFile) async {
    await _revokeFile(_RevokeFileRequest(_clientPtr, tdfFile.path));
  }

  @override
  setOfflineMode(bool enabled) {
    bindings.VSetOffline(_clientPtr, enabled ? 1 : 0);
  }

  @override
  dispose() {
    bindings.VClientDestroy(_clientPtr);
  }

  void _disposePolicy(VPolicyPtr? policyPtr) {
    if (policyPtr == null) return;
    bindings.VPolicyDestroy(policyPtr);
  }
}

extension on EncryptStringParams {
  VEncryptStringParamsPtr get ptr => (this as EncryptStringParamsImpl).ptr;

  VPolicyPtr? get policyPtr => (this as EncryptStringParamsImpl).policyPtr;
}

extension on EncryptFileParams {
  VEncryptFileParamsPtr get ptr => (this as EncryptFileParamsImpl).ptr;

  VPolicyPtr? get policyPtr => (this as EncryptFileParamsImpl).policyPtr;
}

extension on Policy {
  VPolicyPtr get ptr => (this as PolicyImpl).ptr;
}
