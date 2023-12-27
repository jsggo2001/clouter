import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class LogoutApi {
  postRequest(apiUrl, parameter) async {
    var url = Uri.parse('${baseUrl}${apiUrl}');
    print(url);
    print(json.encode(parameter));
    /////////////////////////////////////////
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
      "authorization": parameter  // 헤더에 parameter 넣어줘야함
      },
    ); 

    var statusCode = response.statusCode;
    var headers = response.headers;
    print('로그아웃 response 헤더');
    print(headers);


    if (statusCode == 200) {
      print('로그아웃 성공');
    }
    else {
      print('로그아웃 흐앵');
      print(statusCode);
      return false;
    }
  }

}
