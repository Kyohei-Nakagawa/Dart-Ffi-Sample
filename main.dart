import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef SumFunc = ffi.Uint32 Function(ffi.Uint32 a, ffi.Uint32 b);
typedef SumC = int Function(int a, int b);

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

typedef PrintCharFunc = ffi.Void Function(ffi.Pointer<Utf8> str);
typedef PrintChar = void Function(ffi.Pointer<Utf8> str);

void main() {
  // Open the dynamic library
  var libraryPath = path.join(Directory.current.path, 'cfunction', 'func.dll');
  print(libraryPath);

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  // Look up the C function 'hello_world'
  final HelloWorld hello = dylib
      .lookup<ffi.NativeFunction<HelloWorldFunc>>('hello_world')
      .asFunction();
  // Call the function
  hello();

  final SumC sumc = dylib
      .lookup<ffi.NativeFunction<SumFunc>>('sum')
      .asFunction();

  int a = 3;
  int b = 2;
  int c = sumc(a, b);
  print("$a+$b=$c");

  final str = 'Hello dart ffi.';
  final strUtf8 = str.toNativeUtf8();
  final printChar = dylib.lookupFunction<PrintCharFunc, PrintChar>('print_str');
  
  printChar(strUtf8);
}