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

Future<String> _encryptString(_EncryptStringRequest request) async {
  return _callNative(request, _encryptStringMessageHandler);
}

Future<String> _encryptStringToRCA(_EncryptStringRequest request) async {
  return _callNative(request, _encryptStringToRcaMessageHandler);
}

Future<String> _encryptFile(_EncryptFileRequest request) async {
  return _callNative(request, _encryptFileMessageHandler);
}

Future<String> _encryptFileToRCA(_EncryptFileRequest request) async {
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
      calloc.free(outPolicyId);
      final rcaLink = outRcaLink.value.cast<Utf8>().toDartString();
      calloc.free(outRcaLink);
      mainSendPort.send(_AsyncResponse(status: result, result: rcaLink));
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
      calloc.free(outPolicyId);
      final rcaLink = outRcaLink.value.cast<Utf8>().toDartString();
      calloc.free(outRcaLink);
      mainSendPort.send(_AsyncResponse(status: result, result: rcaLink));
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
      calloc.free(outPolicyId);
      final stringResult = outBytesPtr.value.cast<Utf8>().toDartString();
      calloc.free(outBytesPtr);
      mainSendPort.send(_AsyncResponse(status: result, result: stringResult));
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
      final stringResult = outBytesPtr.value.cast<Utf8>().toDartString(length: outBytesLength.value);
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

abstract class _Request {
  final int _vClientPtrAddress;

  _Request(this._vClientPtrAddress);

  VClientPtr get vClientPtr => VClientPtr.fromAddress(_vClientPtrAddress);
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
