part of 'client.dart';

Future<Res> _callNative<Req extends _Request, Res>(
    Req request, isolateHandled) async {
  final completer = Completer<_AsyncResponse>();
  final worker = Worker();
  await worker.init(
    (data, _) => {
      if (data is _AsyncResponse) {completer.complete(data)}
    },
    isolateHandled,
    initialMessage: request,
  );
  final result = await completer.future;
  _handleError(result);
  return result.result as Res;
}

void _handleError(_AsyncResponse result) {
  switch (result.status) {
    case VSTATUS.VSTATUS_SUCCESS:
      return;
    case VSTATUS.VSTATUS_FAILURE:
      throw NativeError(result.status, "Native code failure");
    case VSTATUS.VSTATUS_INVALID_PARAMS:
      throw NativeError(result.status, "Invalid params");
  }
}

Future<Encrypted<String>> _encryptString(_EncryptStringRequest request) async {
  return _callNative(request, _encryptStringMessageHandler);
}

Future<Encrypted<String>> _encryptStringToRCA(
    _EncryptStringRequest request) async {
  return _callNative(request, _encryptStringToRcaMessageHandler);
}

Future<String> _encryptFile(_EncryptFileRequest request) async {
  return _callNative(request, _encryptFileMessageHandler);
}

Future<Encrypted<String>> _encryptFileToRCA(_EncryptFileRequest request) async {
  return _callNative(request, _encryptFileToRcaMessageHandler);
}

Future<int> _decryptFile(_DecryptFileRequest request) async {
  return _callNative(request, _decryptFileMessageHandler);
}

Future<String> _decryptString(_DecryptStringRequest request) async {
  return _callNative(request, _decryptStringMessageHandler);
}

Future<String> _decryptRcaToString(_DecryptRcaRequest request) async {
  return _callNative(request, _decryptRcaToStringMessageHandler);
}

Future<int> _decryptRcaToFile(_DecryptRcaToFileRequest request) async {
  return _callNative(request, _decryptRcaToFileMessageHandler);
}

Future<int> _fetchPolicyById(_FetchPolicyByIdRequest request) async {
  return _callNative(request, _fetchPolicyByIdMessageHandler);
}

Future<int> _updatePolicyForId(_UpdatePolicyForIdRequest request) async {
  return _callNative(request, _updatePolicyForIdMessageHandler);
}

Future<int> _updatePolicyForFile(_UpdatePolicyForFileRequest request) async {
  return _callNative(request, _updatePolicyForFileMessageHandler);
}

Future<int> _revokePolicy(_RevokePolicyRequest request) async {
  return _callNative(request, _revokePolicyMessageHandler);
}

Future<int> _revokeFile(_RevokeFileRequest request) async {
  return _callNative(request, _revokeFileMessageHandler);
}

_encryptFileMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _EncryptFileRequest) {
    final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final result = bindings.VClientEncryptFile(
      request.vClientPtr,
      request.vEncryptFileParamsPtr,
      outPolicyId,
    );
    bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final policyId = outPolicyId.value.cast<Utf8>().toDartString();
      calloc.free(outPolicyId);
      mainSendPort.send(_AsyncResponse(status: result, result: policyId));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_encryptFileToRcaMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _EncryptFileRequest) {
    final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final outRcaLink = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final result = bindings.VClientEncryptFileToRCA(
      request.vClientPtr,
      request.vEncryptFileParamsPtr,
      outPolicyId,
      outRcaLink,
    );
    bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final policyId = outPolicyId.value.cast<Utf8>().toDartString();
      calloc.free(outPolicyId);
      final rcaLink = outRcaLink.value.cast<Utf8>().toDartString();
      calloc.free(outRcaLink);
      mainSendPort.send(
          _AsyncResponse(status: result, result: Encrypted(policyId, rcaLink)));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_encryptStringToRcaMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _EncryptStringRequest) {
    final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final outRcaLink = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final result = bindings.VClientEncryptStringToRCA(
      request.vClientPtr,
      request.vEncryptStringParamsPtr,
      outPolicyId,
      outRcaLink,
    );
    bindings.VEncryptStringParamsDestroy(request.vEncryptStringParamsPtr);

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final policyId = outPolicyId.value.cast<Utf8>().toDartString();
      calloc.free(outPolicyId);
      final rcaLink = outRcaLink.value.cast<Utf8>().toDartString();
      calloc.free(outRcaLink);
      mainSendPort.send(
          _AsyncResponse(status: result, result: Encrypted(policyId, rcaLink)));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_encryptStringMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _EncryptStringRequest) {
    final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final outBytesPtr = malloc.allocate<VBytesPtr>(sizeOf<VBytesPtr>());
    final outBytesLength =
        malloc.allocate<VBytesLength>(sizeOf<VBytesLength>());
    final result = bindings.VClientEncryptString(
      request.vClientPtr,
      request.vEncryptStringParamsPtr,
      outPolicyId,
      outBytesPtr,
      outBytesLength,
    );

    bindings.VEncryptStringParamsDestroy(request.vEncryptStringParamsPtr);

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final policyId = outPolicyId.value.cast<Utf8>().toDartString();
      calloc.free(outPolicyId);
      final stringResult = outBytesPtr.value
          .cast<Utf8>()
          .toDartString(length: outBytesLength.value);
      calloc.free(outBytesPtr);
      mainSendPort.send(_AsyncResponse(
          status: result, result: Encrypted(policyId, stringResult)));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_decryptFileMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _DecryptFileRequest) {
    final result = bindings.VClientDecryptFile(
      request.vClientPtr,
      request.inputFile.toNativeUtf8().cast(),
      request.outputFile.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_decryptStringMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _DecryptStringRequest) {
    final outBytesPtr = malloc.allocate<VBytesPtr>(sizeOf<VBytesPtr>());
    final outBytesLength =
        malloc.allocate<VBytesLength>(sizeOf<VBytesLength>());
    final result = bindings.VClientDecryptString(
        request.vClientPtr,
        request.tdf3.toNativeUtf8().cast(),
        request.tdf3.length,
        outBytesPtr,
        outBytesLength);

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final stringResult = outBytesPtr.value
          .cast<Utf8>()
          .toDartString(length: outBytesLength.value);
      calloc.free(outBytesPtr);
      mainSendPort.send(_AsyncResponse(status: result, result: stringResult));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_decryptRcaToStringMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _DecryptRcaRequest) {
    final outString = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
    final result = bindings.VClientDecryptRCAToString(
      request.vClientPtr,
      request.rcaLink.toNativeUtf8().cast(),
      outString,
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      final stringResult = outString.value.cast<Utf8>().toDartString();
      calloc.free(outString);
      mainSendPort.send(_AsyncResponse(status: result, result: stringResult));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_decryptRcaToFileMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _DecryptRcaToFileRequest) {
    final result = bindings.VClientDecryptRCAToFile(
      request.vClientPtr,
      request.rcaLink.toNativeUtf8().cast(),
      request.outputFile.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_fetchPolicyByIdMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _FetchPolicyByIdRequest) {
    final policyPtr = malloc.allocate<VPolicyPtr>(sizeOf<VPolicyPtr>());

    final result = bindings.VClientFetchPolicyForUUID(
      request.vClientPtr,
      request.policyId.toNativeUtf8().cast(),
      policyPtr,
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(
          _AsyncResponse(status: result, result: policyPtr.value.address));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_updatePolicyForIdMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _UpdatePolicyForIdRequest) {
    final result = bindings.VClientUpdatePolicyForUUID(
      request.vClientPtr,
      request.vPolicyPtr,
      request.policyId.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_updatePolicyForFileMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _UpdatePolicyForFileRequest) {
    final result = bindings.VClientUpdatePolicyForFile(
      request.vClientPtr,
      request.vPolicyPtr,
      request.tdfFile.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_revokePolicyMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _RevokePolicyRequest) {
    final result = bindings.VClientRevokePolicy(
      request.vClientPtr,
      request.policyId.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

_revokeFileMessageHandler(
  dynamic request,
  SendPort mainSendPort,
  SendErrorFunction onSendError,
) {
  if (request is _RevokeFileRequest) {
    final result = bindings.VClientRevokeFile(
      request.vClientPtr,
      request.tdfFile.toNativeUtf8().cast(),
    );

    if (result == VSTATUS.VSTATUS_SUCCESS) {
      mainSendPort.send(_AsyncResponse(status: result, result: result));
    } else {
      mainSendPort.send(_AsyncResponse(status: result));
    }
  }
}

abstract class _Request {
  final int _vClientPtrAddress;

  _Request(this._vClientPtrAddress);

  VClientPtr get vClientPtr => VClientPtr.fromAddress(_vClientPtrAddress);
}

class _FetchPolicyByIdRequest extends _Request {
  final String policyId;

  _FetchPolicyByIdRequest(VClientPtr vClientPtr, this.policyId)
      : super(vClientPtr.address);
}

class _UpdatePolicyRequest extends _Request {
  final int _policyPtrAddress;

  factory _UpdatePolicyRequest(VClientPtr vClientPtr, VPolicyPtr vPolicyPtr) =>
      _UpdatePolicyRequest._(vClientPtr.address, vPolicyPtr.address);

  _UpdatePolicyRequest._(vClientPtrAddress, this._policyPtrAddress)
      : super(vClientPtrAddress);

  VPolicyPtr get vPolicyPtr => VPolicyPtr.fromAddress(_policyPtrAddress);
}

class _UpdatePolicyForIdRequest extends _UpdatePolicyRequest {
  final String policyId;

  factory _UpdatePolicyForIdRequest(
          VClientPtr vClientPtr, VPolicyPtr vPolicyPtr, String policyId) =>
      _UpdatePolicyForIdRequest._(
          vClientPtr.address, vPolicyPtr.address, policyId);

  _UpdatePolicyForIdRequest._(
      vClientPtrAddress, policyPtrAddress, this.policyId)
      : super._(vClientPtrAddress, policyPtrAddress);
}

class _UpdatePolicyForFileRequest extends _UpdatePolicyRequest {
  final String tdfFile;

  factory _UpdatePolicyForFileRequest(
          VClientPtr vClientPtr, VPolicyPtr vPolicyPtr, String tdfFile) =>
      _UpdatePolicyForFileRequest._(
          vClientPtr.address, vPolicyPtr.address, tdfFile);

  _UpdatePolicyForFileRequest._(
      vClientPtrAddress, policyPtrAddress, this.tdfFile)
      : super._(vClientPtrAddress, policyPtrAddress);
}

class _RevokePolicyRequest extends _Request {
  final String policyId;

  factory _RevokePolicyRequest(VClientPtr vClientPtr, String policyId) =>
      _RevokePolicyRequest._(vClientPtr.address, policyId);

  _RevokePolicyRequest._(vClientPtrAddress, this.policyId)
      : super(vClientPtrAddress);
}

class _RevokeFileRequest extends _Request {
  final String tdfFile;

  factory _RevokeFileRequest(VClientPtr vClientPtr, String tdfFile) =>
      _RevokeFileRequest._(vClientPtr.address, tdfFile);

  _RevokeFileRequest._(vClientPtrAddress, this.tdfFile)
      : super(vClientPtrAddress);
}

class _EncryptStringRequest extends _Request {
  final int _vEncryptStringParamsPtrAddress;

  factory _EncryptStringRequest(VClientPtr vClientPtr,
          VEncryptStringParamsPtr vEncryptStringParamsPtr) =>
      _EncryptStringRequest._(
          vClientPtr.address, vEncryptStringParamsPtr.address);

  _EncryptStringRequest._(
      vClientPtrAddress, this._vEncryptStringParamsPtrAddress)
      : super(vClientPtrAddress);

  VEncryptStringParamsPtr get vEncryptStringParamsPtr =>
      VEncryptStringParamsPtr.fromAddress(_vEncryptStringParamsPtrAddress);
}

class _EncryptFileRequest extends _Request {
  final int _vEncryptFileParamsPtrAddress;

  factory _EncryptFileRequest(
          VClientPtr vClientPtr, VEncryptFileParamsPtr vEncryptFileParamsPtr) =>
      _EncryptFileRequest._(vClientPtr.address, vEncryptFileParamsPtr.address);

  _EncryptFileRequest._(vClientPtrAddress, this._vEncryptFileParamsPtrAddress)
      : super(vClientPtrAddress);

  VEncryptFileParamsPtr get vEncryptFileParamsPtr =>
      VEncryptFileParamsPtr.fromAddress(_vEncryptFileParamsPtrAddress);
}

class _DecryptFileRequest extends _Request {
  final String inputFile;
  final String outputFile;

  factory _DecryptFileRequest(
          VClientPtr vClientPtr, String inputFile, String outputFile) =>
      _DecryptFileRequest._(vClientPtr.address, inputFile, outputFile);

  _DecryptFileRequest._(vClientPtrAddress, this.inputFile, this.outputFile)
      : super(vClientPtrAddress);
}

class _DecryptRcaRequest extends _Request {
  final String rcaLink;

  factory _DecryptRcaRequest(VClientPtr vClientPtr, String rcaLink) =>
      _DecryptRcaRequest._(vClientPtr.address, rcaLink);

  _DecryptRcaRequest._(vClientPtrAddress, this.rcaLink)
      : super(vClientPtrAddress);
}

class _DecryptStringRequest extends _Request {
  final String tdf3;

  factory _DecryptStringRequest(VClientPtr vClientPtr, String tdf3) =>
      _DecryptStringRequest._(vClientPtr.address, tdf3);

  _DecryptStringRequest._(vClientPtrAddress, this.tdf3)
      : super(vClientPtrAddress);
}

class _DecryptRcaToFileRequest extends _DecryptRcaRequest {
  final String outputFile;

  factory _DecryptRcaToFileRequest(
          VClientPtr vClientPtr, String rcaLink, String outputFile) =>
      _DecryptRcaToFileRequest._(vClientPtr.address, rcaLink, outputFile);

  _DecryptRcaToFileRequest._(
    vClientPtrAddress,
    rcaLink,
    this.outputFile,
  ) : super._(vClientPtrAddress, rcaLink);
}

class _AsyncResponse<Res> {
  final Res? result;
  final int status;

  const _AsyncResponse({required this.status, this.result});
}
