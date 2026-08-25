import 'dart:convert';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
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
        response = await http.put(
          url,
          body: jsonEncode(body),
          headers: headers,
        );
        break;
      case RequestType.PATCH:
        response = await http.patch(
          url,
          body: jsonEncode(body),
          headers: headers,
        );
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
        _methodName(type), // كانت 'POST' ثابتة بالكود دايماً - هلق
        // فعلياً بتعتمد على الـ type يلي بتمررها (PUT/DELETE/POST/الخ).
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
      print('===== REQUEST FILES =====');

      for (final file in request.files) {
        print('field => ${file.field}');
        print('filename => ${file.filename}');
        print('contentType => ${file.contentType}');
        print('length => ${file.length}');
      }
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

  /// بيحوّل RequestType enum لنص الـ HTTP Method الحقيقي - مستخدمة
  /// بـ sendMultipartRequest حتى الطلب يترسل بالـ method الصحيح فعلياً
  /// بدل ما يكون POST ثابتة دايماً بغض النظر عن الـ type المُمرَّرة.
  static String _methodName(RequestType type) {
    switch (type) {
      case RequestType.GET:
        return 'GET';
      case RequestType.POST:
        return 'POST';
      case RequestType.PUT:
        return 'PUT';
      case RequestType.DELETE:
        return 'DELETE';
      case RequestType.PATCH:
        return 'PATCH';
    }
  }

  static Future<Uint8List> sendImageRequest({
    required String route,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  }) async {
    var url = Uri.https(baseUrl, route);

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }

    // ✅ Log the full response so you can see what the server actually returned
    debugPrint('❌ UML request failed');
    debugPrint('   Status : ${response.statusCode}');
    debugPrint('   Body   : ${response.body}');
    debugPrint('   URL    : $url');

    throw Exception(
      'Failed to load image — ${response.statusCode}: ${response.body}',
    );
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last.toLowerCase();
    if (ext == 'jpg' || ext == 'jpeg') {
      return MediaType.parse('image/jpeg');
    } else if (ext == 'png') {
      return MediaType.parse('image/png');
    } else if (ext == 'pdf') {
      return MediaType.parse('application/pdf');
    } else {
      return MediaType.parse('image/jpeg');
    }
  }
}
