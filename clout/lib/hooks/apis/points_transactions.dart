import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class PointsTransactionsApi {
  static getRequest(apiUrl, authorization, parameter) async {
    // 3.38.213.43:8008/v1/points/transactions?memberId=8&category=ALL&page=0&size=10
    // var memberId = '';
    // var category = '';
    // var page = '';
    // var size = '';
    var memberId = parameter['memberId'];
    var category = parameter['category'];
    var page = parameter['page'];
    var size = parameter['size'];
    var url = Uri.parse('${baseUrl}${apiUrl}?memberId=${memberId}&category=${category}&page=${page}&size=${size}');
    print(url);
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json",
      "Authorization": authorization  // 헤더에 parameter 넣어줘야함
      },
    );
    print('코드: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('포인트 리스트');
      print(utf8.decode(response.bodyBytes));
      return utf8.decode(response.bodyBytes);
    } else {
      print('포인트 리스트 들어왔는데 에러');
      return null;
    }
  }
}
