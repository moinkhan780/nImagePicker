import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import './response_model.dart';
import 'dart:html' as html;

Future<ResponseModel> setFile(Response r, String n, String key, Map<String, dynamic> headers) async {
  try{
    final dynamic i = html.File( r.bodyBytes, key, headers);

    return ResponseModel(
      platformFile: PlatformFile(
        name  : key,
        size  : i.size,
        bytes : r.bodyBytes,
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
