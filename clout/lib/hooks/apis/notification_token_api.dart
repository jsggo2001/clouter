import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class NotificationTokenApi {
  postRequest(apiUrl, parameter) async {
    var url = Uri.parse('${baseUrl}${apiUrl}');
    print(url);
    print(json.encode(parameter));
    /////////////////////////////////////////
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
      },
      body: json.encode(parameter),
    ); 

    var statusCode = response.statusCode;
    var headers = response.headers;
    print(parameter);
    print(headers);


    if (statusCode == 201) {
      print('알림토큰 성공');
    }
    else {
      print('알림토큰 흐앵');
      print(statusCode);
      return false;
    }
  }

}
