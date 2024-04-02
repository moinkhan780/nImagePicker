import 'dart:html' as html;
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:n_image_picker/src/custom_file.dart';
import './response_model.dart';
import 'package:flutter/foundation.dart';
// import 'dart:js' as js;

CustomFile getInstance() => WebFile();

class WebFile implements CustomFile{
  @override
  Future<ResponseModel> setFile({required final Response response, final String? key, final Map<String, dynamic>? headers}) async {
    try{
      final String filename = key??'' + Random().nextInt(1000).toString()  + DateTime.now().millisecondsSinceEpoch.toString();

      final html.File i = html.File( response.bodyBytes, key??'', headers);

      return ResponseModel(
        platformFile: PlatformFile(
          name  : filename,
          size  : i.size,
          bytes : response.bodyBytes,
          path  : null
        ),
        error: false
      );
    } catch (e){
      return ResponseModel(
        platformFile: PlatformFile(name: '', size: 0),
        error       : true
      );
    }
  }

  @override
  Future<ResponseModel> setFileFromPath(String p) async =>
  ResponseModel(
    platformFile : PlatformFile( name: '', size: 0 ),
    error        : false
  );

  @override
  rm(PlatformFile file) => null;

  @override
  Future<PlatformFile> w(Uint8List? bytes) async =>
  PlatformFile(
    name  : DateTime.now().millisecondsSinceEpoch.toString(),
    size  : bytes?.length??0,
    bytes : bytes
  );
}