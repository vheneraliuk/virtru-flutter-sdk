part of 'client.dart';

Future<Res> _callNative<Req extends _Request, Res>({
  required Req request,
  required isolateHandled,
}) async {
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

_asyncNativeCall<Req extends _Request, Res, Nat extends _NativeResult>({
  required Nat Function(Req request) requestCall,
  required Res Function(Nat nativeResult) resultTransform,
}) =>
    (
      dynamic request,
      SendPort mainSendPort,
      SendErrorFunction onSendError,
    ) {
      if (request is Req) {
        final result = requestCall(request);

        if (result.status == VSTATUS.VSTATUS_SUCCESS) {
          mainSendPort.send(_AsyncResponse(
              status: result.status, result: resultTransform(result)));
        } else {
          mainSendPort.send(_AsyncResponse(status: result.status));
        }
      }
    };

Future<Encrypted<String>> _encryptString(_EncryptStringRequest request) async {
  return _callNative(
      request: request,
      isolateHandled: _asyncNativeCall<_EncryptStringRequest, Encrypted<String>,
          _EncryptedString>(
        requestCall: (request) {
          final outPolicyId =
              malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
          final outBytesPtr = malloc.allocate<VBytesPtr>(sizeOf<VBytesPtr>());
          final outBytesLength =
              malloc.allocate<VBytesLength>(sizeOf<VBytesLength>());
          final status = bindings.VClientEncryptString(
            request.vClientPtr,
            request.vEncryptStringParamsPtr,
            outPolicyId,
            outBytesPtr,
            outBytesLength,
          );

          bindings.VEncryptStringParamsDestroy(request.vEncryptStringParamsPtr);
          return _EncryptedString(
              status, outPolicyId, outBytesPtr, outBytesLength);
        },
        resultTransform: (nativeResult) {
          final policyId = nativeResult.outPolicyId.toDartString();
          calloc.free(nativeResult.outPolicyId);
          final stringResult = nativeResult.outBytesPtr
              .toDartString(length: nativeResult.outBytesLength.value);
          calloc.free(nativeResult.outBytesPtr);
          return Encrypted(policyId, stringResult);
        },
      ));
}

Future<Encrypted<String>> _encryptStringToRCA(
    _EncryptStringRequest request) async {
  return _callNative(
      request: request,
      isolateHandled: _asyncNativeCall<_EncryptStringRequest, Encrypted<String>,
          _EncryptedRca>(
        requestCall: (request) {
          final outPolicyId =
              malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
          final outRcaLink =
              malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
          final status = bindings.VClientEncryptStringToRCA(
            request.vClientPtr,
            request.vEncryptStringParamsPtr,
            outPolicyId,
            outRcaLink,
          );
          bindings.VEncryptStringParamsDestroy(request.vEncryptStringParamsPtr);
          return _EncryptedRca(status, outPolicyId, outRcaLink);
        },
        resultTransform: (nativeResult) {
          final policyId = nativeResult.outPolicyId.toDartString();
          calloc.free(nativeResult.outPolicyId);
          final rcaLink = nativeResult.outRcaLink.toDartString();
          calloc.free(nativeResult.outRcaLink);
          return Encrypted(policyId, rcaLink);
        },
      ));
}

Future<String> _encryptFile(_EncryptFileRequest request) async {
  return _callNative(
      request: request,
      isolateHandled: _asyncNativeCall<_EncryptFileRequest, String, _Policy>(
        requestCall: (request) {
          final outPolicyId =
              malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
          final status = bindings.VClientEncryptFile(
            request.vClientPtr,
            request.vEncryptFileParamsPtr,
            outPolicyId,
          );
          bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);
          return _Policy(status, outPolicyId);
        },
        resultTransform: (nativeResult) {
          final policyId = nativeResult.outPolicyId.toDartString();
          calloc.free(nativeResult.outPolicyId);
          return policyId;
        },
      ));
}

Future<Encrypted<String>> _encryptFileToRCA(_EncryptFileRequest request) async {
  return _callNative(
    request: request,
    isolateHandled:
        _asyncNativeCall<_EncryptFileRequest, Encrypted<String>, _EncryptedRca>(
      requestCall: (request) {
        final outPolicyId =
            malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
        final outRcaLink =
            malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
        final status = bindings.VClientEncryptFileToRCA(
          request.vClientPtr,
          request.vEncryptFileParamsPtr,
          outPolicyId,
          outRcaLink,
        );
        bindings.VEncryptFileParamsDestroy(request.vEncryptFileParamsPtr);
        return _EncryptedRca(status, outPolicyId, outRcaLink);
      },
      resultTransform: (nativeResult) {
        final policyId = nativeResult.outPolicyId.toDartString();
        calloc.free(nativeResult.outPolicyId);
        final rcaLink = nativeResult.outRcaLink.toDartString();
        calloc.free(nativeResult.outRcaLink);
        return Encrypted(policyId, rcaLink);
      },
    ),
  );
}

Future<int> _decryptFile(_DecryptFileRequest request) async {
  return _callNative(
    request: request,
    isolateHandled: _asyncNativeCall<_DecryptFileRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientDecryptFile(
          request.vClientPtr,
          request.inputFile.toNativeString(),
          request.outputFile.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
}

Future<String> _decryptString(_DecryptStringRequest request) async {
  return _callNative(
    request: request,
    isolateHandled:
        _asyncNativeCall<_DecryptStringRequest, String, _DecryptedString>(
      requestCall: (request) {
        final outBytesPtr = malloc.allocate<VBytesPtr>(sizeOf<VBytesPtr>());
        final outBytesLength =
            malloc.allocate<VBytesLength>(sizeOf<VBytesLength>());
        final status = bindings.VClientDecryptString(
            request.vClientPtr,
            request.tdf3.toNativeString(),
            request.tdf3.length,
            outBytesPtr,
            outBytesLength);
        return _DecryptedString(status, outBytesPtr, outBytesLength);
      },
      resultTransform: (nativeResult) {
        final stringResult = nativeResult.outBytesPtr
            .toDartString(length: nativeResult.outBytesLength.value);
        calloc.free(nativeResult.outBytesPtr);
        return stringResult;
      },
    ),
  );
}

Future<String> _decryptRcaToString(_DecryptRcaRequest request) async {
  return _callNative(
    request: request,
    isolateHandled: _asyncNativeCall<_DecryptRcaRequest, String, _DecryptedRca>(
      requestCall: (request) {
        final outString =
            malloc.allocate<Pointer<Char>>(sizeOf<Pointer<Char>>());
        final status = bindings.VClientDecryptRCAToString(
          request.vClientPtr,
          request.rcaLink.toNativeString(),
          outString,
        );
        return _DecryptedRca(status, outString);
      },
      resultTransform: (nativeResult) {
        final stringResult = nativeResult.result.toDartString();
        calloc.free(nativeResult.result);
        return stringResult;
      },
    ),
  );
}

Future<int> _decryptRcaToFile(_DecryptRcaToFileRequest request) async {
  return _callNative(
    request: request,
    isolateHandled:
        _asyncNativeCall<_DecryptRcaToFileRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientDecryptRCAToFile(
          request.vClientPtr,
          request.rcaLink.toNativeString(),
          request.outputFile.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
}

Future<int> _fetchPolicyById(_FetchPolicyByIdRequest request) async {
  return _callNative(
    request: request,
    isolateHandled: _asyncNativeCall<_FetchPolicyByIdRequest, int, _PolicyId>(
      requestCall: (request) {
        final policyPtr = malloc.allocate<VPolicyPtr>(sizeOf<VPolicyPtr>());

        final status = bindings.VClientFetchPolicyForUUID(
          request.vClientPtr,
          request.policyId.toNativeString(),
          policyPtr,
        );
        return _PolicyId(status, policyPtr.value.address);
      },
      resultTransform: (nativeResult) => nativeResult.policyIdAddress,
    ),
  );
}

Future<int> _updatePolicyForId(_UpdatePolicyForIdRequest request) async {
  return _callNative(
    request: request,
    isolateHandled:
        _asyncNativeCall<_UpdatePolicyForIdRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientUpdatePolicyForUUID(
          request.vClientPtr,
          request.vPolicyPtr,
          request.policyId.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
}

Future<int> _updatePolicyForFile(_UpdatePolicyForFileRequest request) async {
  return _callNative(
    request: request,
    isolateHandled:
        _asyncNativeCall<_UpdatePolicyForFileRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientUpdatePolicyForFile(
          request.vClientPtr,
          request.vPolicyPtr,
          request.tdfFile.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
}

Future<int> _revokePolicy(_RevokePolicyRequest request) async {
  return _callNative(
    request: request,
    isolateHandled: _asyncNativeCall<_RevokePolicyRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientRevokePolicy(
          request.vClientPtr,
          request.policyId.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
}

Future<int> _revokeFile(_RevokeFileRequest request) async {
  return _callNative(
    request: request,
    isolateHandled: _asyncNativeCall<_RevokeFileRequest, int, _NativeResult>(
      requestCall: (request) {
        final status = bindings.VClientRevokeFile(
          request.vClientPtr,
          request.tdfFile.toNativeString(),
        );
        return _NativeResult(status);
      },
      resultTransform: (nativeResult) => nativeResult.status,
    ),
  );
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

class _NativeResult {
  final int status;

  _NativeResult(this.status);
}

class _Policy extends _NativeResult {
  final Pointer<Pointer<Char>> outPolicyId;

  _Policy(super.status, this.outPolicyId);
}

class _PolicyId extends _NativeResult {
  final int policyIdAddress;

  _PolicyId(super.status, this.policyIdAddress);
}

class _DecryptedRca extends _NativeResult {
  final Pointer<Pointer<Char>> result;

  _DecryptedRca(super.status, this.result);
}

class _EncryptedString extends _Policy {
  final Pointer<VBytesPtr> outBytesPtr;
  final Pointer<VBytesLength> outBytesLength;

  _EncryptedString(
    super.status,
    super.outPolicyId,
    this.outBytesPtr,
    this.outBytesLength,
  );
}

class _DecryptedString extends _NativeResult {
  final Pointer<VBytesPtr> outBytesPtr;
  final Pointer<VBytesLength> outBytesLength;

  _DecryptedString(
    super.status,
    this.outBytesPtr,
    this.outBytesLength,
  );
}

class _EncryptedRca extends _Policy {
  final Pointer<Pointer<Char>> outRcaLink;

  _EncryptedRca(
    super.status,
    super.outPolicyId,
    this.outRcaLink,
  );
}

//convert from Pointer<Pointer<Char>> to dart string (utf8) and vice versa (dart string to native string)

extension NativeConverter on String {
  toNativeString() => toNativeUtf8().cast<Char>();

}

extension PointerCharConverter on Pointer<Pointer<Char>> {
  toDartString({int? length}) => value.toDartString(length: length);
}

extension PointerUnsignedCharConverter on Pointer<Pointer<UnsignedChar>> {
  toDartString({int? length}) =>
      value.cast<Utf8>().toDartString(length: length);
}

extension CharConverter on Pointer<Char> {
  toDartString({int? length}) => cast<Utf8>().toDartString(length: length);
}
