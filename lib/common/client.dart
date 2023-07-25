import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/client.dart';
import 'package:virtru_sdk_flutter/common/encrypt_params.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/native_error.dart';
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
  int enableConsoleLogging() {
    return bindings.VEnableConsoleLogging(_clientPtr, VLogLevel.VLogLevelDebug);
  }

  @override
  int setZipProtocol(bool enableZip) {
    return bindings.VSetProtocol(_clientPtr,
        enableZip ? VProtocol.VProtocolZip : VProtocol.VProtocolHtml);
  }

  @override
  Future<String> encryptString(EncryptStringParams params) async {
    return _encryptString(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  @override
  Future<String> encryptStringToRCA(EncryptStringParams params) async {
    return _encryptStringToRCA(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  @override
  Future<String> encryptFile(EncryptFileParams params) async {
    return _encryptFile(_EncryptFileRequest(_clientPtr, params.ptr));
  }

  @override
  Future<String> encryptFileToRCA(EncryptFileParams params) async {
    return _encryptFileToRCA(_EncryptFileRequest(_clientPtr, params.ptr));
  }

  @override
  Future<int> decryptFile(File inputFile, File outputFile) async {
    return _decryptFile(_DecryptFileRequest(
      _clientPtr,
      inputFile.path,
      outputFile.path,
    ));
  }

  @override
  Future<String> decryptRcaToString(String rcaLink) async {
    return _decryptRcaToString(_DecryptRcaRequest(
      _clientPtr,
      rcaLink,
    ));
  }

  @override
  Future<int> decryptRcaToFile(String rcaLink, String outputFile) async {
    return _decryptRcaToFile(_DecryptRcaToFileRequest(
      _clientPtr,
      rcaLink,
      outputFile,
    ));
  }

  @override
  void dispose() {
    bindings.VClientDestroy(_clientPtr);
  }
}

extension on EncryptStringParams {
  VEncryptStringParamsPtr get ptr => (this as EncryptStringParamsImpl).ptr;
}

extension on EncryptFileParams {
  VEncryptFileParamsPtr get ptr => (this as EncryptFileParamsImpl).ptr;
}
