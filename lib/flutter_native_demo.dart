import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';

final DynamicLibrary nativeAddLib = Platform.isMacOS || Platform.isIOS
    ? DynamicLibrary.process()
    : DynamicLibrary.open('libNativeAdd.${Platform.isWindows ? 'dll' : 'so'}');

final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
    .asFunction();

class FlutterNativeDemo {
  static const MethodChannel _channel = MethodChannel('flutter_native_demo');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
