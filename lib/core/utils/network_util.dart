import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:tech_talk/core/enum/request_type.dart';

class NetworkUtil {
  static String baseUrl = 'gradback.neotonicglobal.com';

  static Future<Map<String, dynamic>> sendRequest({
    required RequestType type,
    required String route,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    var url = Uri.https(baseUrl, route, params);
    http.Response response;

    switch (type) {
      case RequestType.POST:
        response = await http.post(
          url,
          body: jsonEncode(body),
          headers: headers,
        );
        break;
      case RequestType.GET:
        response = await http.get(url, headers: headers);
        break;
      case RequestType.DELETE:
        response = await http.delete(
          url,
          body: jsonEncode(body),
          headers: headers,
        );
        break;
      case RequestType.PUT:
        response = await http.put(url, body: body, headers: headers);
        break;
    }

    Map<String, dynamic> jsonResponse = {};

    String decodeBody = Utf8Codec().decode(response.bodyBytes);
    dynamic result;
    try {
      result = jsonDecode(decodeBody);
    } catch (e) {}

    jsonResponse.putIfAbsent(
      'response',
      () => result ?? {'message': decodeBody},
    );
    jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

    return jsonResponse;
  }

  static Future<dynamic> sendMultipartRequest({
    required String route,
    required RequestType type,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    Map<String, String>? fields, //!Text,
    Map<String, String>? files, //*File,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.https(baseUrl, route, params),
      );

      var _filesKeyList = files!.keys.toList();
      var _filesNameList = files.values.toList();

      for (int i = 0; i < _filesNameList.length; i++) {
        if (_filesNameList[i].isNotEmpty) {
          var multipartFile = http.MultipartFile.fromPath(
            _filesKeyList[i], //! image_profile
            _filesNameList[i], //* File path
            filename: path.basename(_filesNameList[i]),
            contentType: getContentType(_filesNameList[i]),
          );
          request.files.add(await multipartFile);
        }
      }

      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      var response = await request.send();

      Map<String, dynamic> responseJson = {};

      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      var value = await response.stream.bytesToString();
      responseJson.putIfAbsent('response', () => jsonDecode(value));

      return responseJson;
    } catch (error) {
      BotToast.showText(text: error.toString());
      return {
        'statusCode': 500,
        'response': {'message': error.toString()},
      };
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last;
    if (ext == "png" || ext == "jpeg") {
      return MediaType.parse("image/jpg");
    } else if (ext == 'pdf') {
      return MediaType.parse("application/pdf");
    } else {
      return MediaType.parse("image/jpg");
    }
  }
}
