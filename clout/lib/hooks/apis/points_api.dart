import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class PointsApi {
  static getRequest(apiUrl, memberId, authorization) async {
    var url = Uri.parse('${baseUrl}${apiUrl}?memberId=${memberId}');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json", "Authorization": authorization},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return utf8.decode(response.bodyBytes);
      } else {
        print('포인트 들어왔는데 에러 - ${response.statusCode}');
        print(utf8.decode(response.bodyBytes));
        return null;
      }
    } catch (e) {
      print('네트워크 오류 또는 예외 발생: $e');
      return null;
    }
  }
}
