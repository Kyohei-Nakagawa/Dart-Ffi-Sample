# Dart-Ffi-Sample

1. VSCode で FfiSample フォルダを開く
2. VSCode のターミナルで dart pub get を実行する
3. 以下のコマンドで dll を作成する。  
  cl.exe にパスが通っている必要がある。  
  Visual Studio のコマンドプロンプトとならたぶん最初から通っている。  
  ```
  cd path/to/FfiSample/cfunction
  cl func.c /LD
  ```
4. VSCode のターミナルで dart main.dart を実行する
5. 実行結果が表示される
