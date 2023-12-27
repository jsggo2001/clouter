import 'dart:convert';
import 'package:clout/type.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class RegisterApi {
  postRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl');
    print(url);
    print(json.encode(parameter));
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(parameter),
    );

    print('post 통신 실행 완료');

    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = [statusCode, body];

    print('상태코드');
    print(statusCode);

    return returnVal;
  }

  getRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl$parameter');
    print(url);
    print(json.encode(parameter));
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    print('get 통신 실행 완료');
    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = [statusCode, body];

    print('상태코드');
    print(statusCode);

    return returnVal;
  }

  dioPostRequest(
      apiUrl, Clouter parameter, List<MultipartFile> multiPartFiles) async {
    var dio = Dio();
    try {
      dio.options.contentType = 'multipart/form-data';
      // dio.options.contentType = 'application/json';
      dio.options.maxRedirects.isFinite;

      FormData formData = FormData.fromMap({
        'createClrRequest': MultipartFile.fromString(
            jsonEncode(parameter.toJson()),
            contentType: MediaType.parse('application/json')),
        'files': multiPartFiles
      });

      print(jsonEncode(parameter));
      print(multiPartFiles);

      var response = await dio.post('$baseUrl$apiUrl', data: formData);
      print(response);
      print(response.data);
    } catch (e) {
      print('에러 발생');
      print(e);
    }
  }
}
