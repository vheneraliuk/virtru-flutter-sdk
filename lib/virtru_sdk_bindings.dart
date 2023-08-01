import 'dart:ffi';
import 'dart:io';

import 'package:virtru_sdk/virtru_sdk_bindings_generated.dart';

const String _libName = 'virtru_tdf3';

/// The dynamic library in which the symbols for [VirtruSdkFlutterBindings] can be found.
final DynamicLibrary _dylib = () {
  // for tests purposes
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return _getLibForTests();
  }
  if (Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  } else if (Platform.isAndroid) {
    return DynamicLibrary.open('lib$_libName.so');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('lib$_libName.dylib');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

DynamicLibrary _getLibForTests() {
  if (Platform.isMacOS) {
    return DynamicLibrary.open('macos/lib$_libName.dylib');
  }
  throw UnsupportedError('Unknown tests platform: ${Platform.operatingSystem}');
}

/// The bindings to the native functions in [_dylib].
VirtruSdkFlutterBindings get bindings => _bindings;

final VirtruSdkFlutterBindings _bindings = VirtruSdkFlutterBindings(_dylib);
