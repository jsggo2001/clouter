import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future loadEnv() async {
  await dotenv.load(fileName: ".env");
}

String baseUrl = dotenv.env.toString();

void userApi(apiUrl) async {
  var url = Uri.http(baseUrl, apiUrl);
  http.Response response = await http.get(url, headers: {
    "Accept": "application/json"
  }); // 여기에 authorization header를 넣어야 될듯?
}
