import 'dart:io';

import 'package:virtru_sdk_flutter/client.dart';
import 'package:virtru_sdk_flutter/encrypt_params.dart';

class ClientImpl implements Client{
  @override
  Future<int> decryptFile(File inputFile, File outputFile) {
    // TODO: implement decryptFile
    throw UnimplementedError();
  }

  @override
  Future<int> decryptRcaToFile(String rcaLink, String outputFile) {
    // TODO: implement decryptRcaToFile
    throw UnimplementedError();
  }

  @override
  Future<String> decryptRcaToString(String rcaLink) {
    // TODO: implement decryptRcaToString
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  int enableConsoleLogging() {
    // TODO: implement enableConsoleLogging
    throw UnimplementedError();
  }

  @override
  Future<String> encryptFile(EncryptFileParams params) {
    // TODO: implement encryptFile
    throw UnimplementedError();
  }

  @override
  Future<String> encryptFileToRCA(EncryptFileParams params) {
    // TODO: implement encryptFileToRCA
    throw UnimplementedError();
  }

  @override
  Future<String> encryptString(EncryptStringParams params) {
    // TODO: implement encryptString
    throw UnimplementedError();
  }

  @override
  Future<String> encryptStringToRCA(EncryptStringParams params) {
    // TODO: implement encryptStringToRCA
    throw UnimplementedError();
  }

  @override
  int setZipProtocol(bool enableZip
      ) {
    // TODO: implement setZipProtocol
    throw UnimplementedError();
  }

}