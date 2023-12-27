import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class NormalApi {
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
    var returnVal = {'statusCode': statusCode, 'body': body};

    print('상태코드');
    print(statusCode);

    return returnVal;
  }

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
}
