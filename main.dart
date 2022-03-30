import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;
import 'dart:convert' show utf8;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef SumFunc = ffi.Uint32 Function(ffi.Uint32 a, ffi.Uint32 b);
typedef SumC = int Function(int a, int b);

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

typedef PrintCharFunc = ffi.Void Function(ffi.Pointer<Utf8> str);
typedef PrintChar = void Function(ffi.Pointer<Utf8> str);

// Example of handling a simple C struct
class Coordinate extends ffi.Struct {
  @ffi.Double()
  external double latitude;

  @ffi.Double()
  external double longitude;
}

// Example of a complex struct (contains a string and a nested struct)
class Place extends ffi.Struct {
  external ffi.Pointer<Utf8> name;

  external Coordinate coordinate;
}

// C function: struct Coordinate create_coordinate(double latitude, double longitude)
typedef CreateCoordinateNative = Coordinate Function(
    ffi.Double latitude, ffi.Double longitude);
typedef CreateCoordinate = Coordinate Function(
    double latitude, double longitude);

// C function: struct Place create_place(char *name, double latitude, double longitude)
typedef CreatePlaceNative = Place Function(
    ffi.Pointer<Utf8> name, ffi.Double latitude, ffi.Double longitude);
typedef CreatePlace = Place Function(
    ffi.Pointer<Utf8> name, double latitude, double longitude);

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

  final str = 'Hello dart ffi.\n';
  final strUtf8 = str.toNativeUtf8();
  final printChar = dylib.lookupFunction<PrintCharFunc, PrintChar>('print_str');
  printChar(strUtf8);

  final createCoordinate =
      dylib.lookupFunction<CreateCoordinateNative, CreateCoordinate>(
          'create_coordinate');
  final coordinate = createCoordinate(3.5, 4.6);
  print(
      'Coordinate is lat ${coordinate.latitude}, long ${coordinate.longitude}');

  final myHomeStr = utf8.decode(utf8.encode('My Home'));
  final myHomeUtf8 = myHomeStr.toNativeUtf8();
  final createPlace =
      dylib.lookupFunction<CreatePlaceNative, CreatePlace>('create_place');
  final place = createPlace(myHomeUtf8, 42.0, 24.0);
  calloc.free(myHomeUtf8);
  final nameUtf8 = place.name;
  final len = nameUtf8.length;
  final name = nameUtf8.toDartString();
  final coord = place.coordinate;
  print(
      'The name of my place is $name at ${coord.latitude}, ${coord.longitude}');

}