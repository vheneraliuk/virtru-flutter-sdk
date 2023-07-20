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

_decryptStringMessageHandler(
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

/// A response with the result of `decryptString`.
///
/// Typically sent from one isolate to another.
class _AsyncResponse<Res> {
  final Res? result;
  final int status;

  const _AsyncResponse({required this.status, this.result});
}
//
// sealed class _AsyncResult {
//   final int resultCode;
//
//   _AsyncResult(this.resultCode);
// }
//
// class _Success<T> extends _AsyncResult {
//   final T result;
//
//   _Success(this.result) : super(0);
// }
//
// class _Failure extends _AsyncResult {
//   _Failure() : super(1);
// }
//
// class _InvalidParams extends _AsyncResult {
//   _InvalidParams() : super(2);
// }
//
// /// Counter to identify [_EncryptStringRequest]s and [_AsyncResponse]s.
// var _nextRequestId = 0;
//
// /// Mapping from [_EncryptStringRequest] `id`s to the completers corresponding to the correct future of the pending request.
// final _requests = <int, Completer<_AsyncResult>>{};
//
// final _helperIsolateEncryptString =
//     _createHelperIsolate<_EncryptStringRequest>((request) {
//   final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
//   final outBytesPtr = malloc.allocate<VBytesPtr>(sizeOf<VBytesPtr>());
//   final outBytesLength = malloc.allocate<VBytesLength>(sizeOf<VBytesLength>());
//   final result = bindings.VClientEncryptString(
//     request.vClientPtr,
//     request.vEncryptStringParamsPtr,
//     outPolicyId,
//     outBytesPtr,
//     outBytesLength,
//   );
//
//   bindings.VEncryptStringParamsDestroy(request.vEncryptStringParamsPtr);
//
//   if (result == VSTATUS.VSTATUS_SUCCESS) {
//     calloc.free(outPolicyId);
//     final stringResult = outBytesPtr.value.cast<Utf8>().toDartString();
//     calloc.free(outBytesPtr);
//     return _AsyncResponse(request.id, _Success(stringResult));
//   } else if (result == VSTATUS.VSTATUS_INVALID_PARAMS) {
//     return _AsyncResponse(request.id, _InvalidParams());
//   } else {
//     return _AsyncResponse(request.id, _Failure());
//   }
// });
//
// final _helperIsolateEncryptFile =
//     _createHelperIsolate<_EncryptFileRequest>((request) {
//   final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
//   final result = bindings.VClientEncryptFile(
//     request.vClientPtr,
//     request.vEncryptFileParamsPtr,
//     outPolicyId,
//   );
//   bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);
//
//   if (result == VSTATUS.VSTATUS_SUCCESS) {
//     final policyId = outPolicyId.value.cast<Utf8>().toDartString();
//     calloc.free(outPolicyId);
//     return _AsyncResponse(request.id, _Success(policyId));
//   } else if (result == VSTATUS.VSTATUS_INVALID_PARAMS) {
//     return _AsyncResponse(request.id, _InvalidParams());
//   } else {
//     return _AsyncResponse(request.id, _Failure());
//   }
// });
//
// final _helperIsolateEncryptFileToRCA =
//     _createHelperIsolate<_EncryptFileRequest>((request) {
//   final outPolicyId = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
//   final outRcaLink = malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
//   final result = bindings.VClientEncryptFileToRCA(
//     request.vClientPtr,
//     request.vEncryptFileParamsPtr,
//     outPolicyId,
//     outRcaLink,
//   );
//   bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);
//
//   if (result == VSTATUS.VSTATUS_SUCCESS) {
//     calloc.free(outPolicyId);
//     final rcaLink = outRcaLink.value.cast<Utf8>().toDartString();
//     calloc.free(outRcaLink);
//     return _AsyncResponse(request.id, _Success(rcaLink));
//   } else if (result == VSTATUS.VSTATUS_INVALID_PARAMS) {
//     return _AsyncResponse(request.id, _InvalidParams());
//   } else {
//     return _AsyncResponse(request.id, _Failure());
//   }
// });
//
// final _helperIsolateDecryptFile =
//     _createHelperIsolate<_DecryptFileRequest>((request) {
//   final result = bindings.VClientDecryptFile(
//     request.vClientPtr,
//     request._inputFile.toNativeUtf8().cast(),
//     request._outputFile.toNativeUtf8().cast(),
//   );
//
//   if (result == VSTATUS.VSTATUS_SUCCESS) {
//     return _AsyncResponse(request.id, _Success(result));
//   } else if (result == VSTATUS.VSTATUS_INVALID_PARAMS) {
//     return _AsyncResponse(request.id, _InvalidParams());
//   } else {
//     return _AsyncResponse(request.id, _Failure());
//   }
// });
//
// _createHelperIsolate<Req extends _Request>(
//         _AsyncResponse callNative(Req request)) =>
//     () async {
// // The helper isolate is going to send us back a SendPort, which we want to
// // wait for.
//       final completer = Completer<SendPort>();
//
// // Receive port on the main isolate to receive messages from the helper.
// // We receive two types of messages:
// // 1. A port to send messages on.
// // 2. Responses to requests we sent.
//       final receivePort = ReceivePort()
//         ..listen((dynamic data) {
//           if (data is SendPort) {
// // The helper isolate sent us the port on which we can sent it requests.
//             completer.complete(data);
//             return;
//           }
//           if (data is _AsyncResponse) {
// // The helper isolate sent us a response to a request we sent.
//             final completer = _requests.remove(data.id)!;
//             completer.complete(data.result);
//             return;
//           }
//           throw UnsupportedError(
//               'Unsupported message type: ${data.runtimeType}');
//         });
//
// // Start the helper isolate.
//       await Isolate.spawn((SendPort sendPort) async {
//         final helperReceivePort = ReceivePort()
//           ..listen((dynamic data) {
// // On the helper isolate listen to requests and respond to them.
//             if (data is Req) {
//               sendPort.send(callNative(data));
//               return;
//             }
//             throw UnsupportedError(
//                 'Unsupported message type: ${data.runtimeType}');
//           });
//
// // Send the port to the main isolate on which we can receive requests.
//         sendPort.send(helperReceivePort.sendPort);
//       }, receivePort.sendPort);
//
//       // Wait until the helper isolate has sent us back the SendPort on which we
//       // can start sending requests.
//       return completer.future;
//     }();
