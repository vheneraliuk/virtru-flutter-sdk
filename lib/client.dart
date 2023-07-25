import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_isolate/easy_isolate.dart';
import 'package:ffi/ffi.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';
import 'package:virtru_sdk_flutter/native_error.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter_bindings.dart';

part 'client_helper.dart';

class Client {
  final VClientPtr _clientPtr;

  factory Client.withAppId({
    required String userId,
    required String appId,
  }) =>
      Client._(
        bindings.VClientCreateWithAppId(
          userId.toNativeUtf8().cast(),
          appId.toNativeUtf8().cast(),
        ),
      );

  factory Client.withOIDC({
    required String owner,
    required String organizationName,
    required String clientId,
    required String clientSecret,
  }) =>
      Client._(
        bindings.VClientCreateWithOIDC(
          owner.toNativeUtf8().cast(),
          organizationName.toNativeUtf8().cast(),
          clientId.toNativeUtf8().cast(),
          clientSecret.toNativeUtf8().cast(),
        ),
      );

  Client._(this._clientPtr);

  int enableConsoleLogging() {
    return bindings.VEnableConsoleLogging(_clientPtr, VLogLevel.VLogLevelDebug);
  }

  int setZipProtocol(bool enableZip) {
    return bindings.VSetProtocol(_clientPtr,
        enableZip ? VProtocol.VProtocolZip : VProtocol.VProtocolHtml);
  }

  Future<String> encryptString(EncryptStringParams params) async {
    return _encryptString(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  Future<String> encryptStringToRCA(EncryptStringParams params) async {
    return _encryptStringToRCA(_EncryptStringRequest(_clientPtr, params.ptr));
  }

  Future<String> encryptFile(EncryptFileParams params) async {
    return _encryptFile(_EncryptFileRequest(_clientPtr, params.ptr));
  }

  Future<String> encryptFileToRCA(EncryptFileParams params) async {
    return _encryptFileToRCA(_EncryptFileRequest(_clientPtr, params.ptr));
  }

  Future<int> decryptFile(File inputFile, File outputFile) async {
    return _decryptFile(_DecryptFileRequest(
      _clientPtr,
      inputFile.path,
      outputFile.path,
    ));
  }

  Future<String> decryptRcaToString(String rcaLink) async {
    return _decryptRcaToString(_DecryptRcaRequest(
      _clientPtr,
      rcaLink,
    ));
  }

  Future<int> decryptRcaToFile(String rcaLink, String outputFile) async {
    return _decryptRcaToFile(_DecryptRcaToFileRequest(
      _clientPtr,
      rcaLink,
      outputFile,
    ));
  }

  void dispose() {
    bindings.VClientDestroy(_clientPtr);
  }
}
