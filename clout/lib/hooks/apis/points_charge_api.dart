import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class PointsChargeAPI {
  postRequest(apiUrl, auth, parameter) async {
    var url = Uri.parse('${baseUrl}${apiUrl}');
    // http://3.38.213.43:8008/v1/points/charge
    print(url);
    print(json.encode(parameter));
    /////////////////////////////////////////
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json",
      "Authorization": auth
      },
      body: json.encode(parameter)
    ); 
    
    var statusCode = response.statusCode;
    var headers = response.headers;
    print('충전 response 헤더');
    print(headers);
    print(response.body);

    if (statusCode == 200) {
      print('충전 성공');
    }
    else {
      print('충전 흐앵');
      print(statusCode);
      return false;
    }
  }

}
