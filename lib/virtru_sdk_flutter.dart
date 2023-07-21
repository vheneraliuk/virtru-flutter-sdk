import 'dart:ffi';
import 'dart:io';

import 'package:virtru_sdk_flutter/virtru_sdk_bindings_generated.dart';

export 'client.dart';
export 'encrypt_params.dart';
export 'policy.dart';
export 'native_error.dart';

const String _libName = 'virtru_tdf3';

/// The dynamic library in which the symbols for [VirtruSdkFlutterBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid /*|| Platform.isLinux*/) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isMacOS) {
    return DynamicLibrary.open('lib$_libName.dylib');
  }
  /*if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }*/
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
VirtruSdkFlutterBindings get bindings => _bindings;

final VirtruSdkFlutterBindings _bindings = VirtruSdkFlutterBindings(_dylib);
