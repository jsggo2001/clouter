import 'dart:convert';
import 'dart:io';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

String baseUrl = dotenv.env['CLOUT_APP_BASE_URL']!;

class AuthorizedApi {
  final userController = Get.find<UserController>();
  getRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl$parameter');
    print(url);
    print(json.encode(parameter));
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': userController.accessToken
      },
    );
    print('get 통신 실행 완료');
    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = {
      'statusCode': statusCode,
      'body': body,
    };

    print('상태코드');
    print(statusCode);

    if (statusCode == 401) {
      print('만료된 토큰');
      reissueToken();
    } else {
      return returnVal;
    }
  }

  postRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl');
    print(url);
    print(json.encode(parameter));
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': userController.accessToken
      },
      body: json.encode(parameter),
    );

    print('post 통신 실행 완료');

    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = {
      'statusCode': statusCode,
      'body': body,
    };

    print('상태코드');
    print(statusCode);
    print(body);

    if (statusCode == 401) {
      print('만료된 토큰');
      reissueToken();
    } else {
      return returnVal;
    }
  }

  putRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl');
    print(url);
    print(json.encode(parameter));
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': userController.accessToken
      },
      body: json.encode(parameter),
    );

    print('put 통신 실행 완료');

    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = {
      'statusCode': statusCode,
      'body': body,
    };
    print(body);

    print('상태코드');
    print(statusCode);

    if (statusCode == 401) {
      print('만료된 토큰');
      reissueToken();
    } else {
      return returnVal;
    }
  }

  patchRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl');
    print(url);
    print(json.encode(parameter));
    http.Response response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': userController.accessToken
      },
      body: json.encode(parameter),
    );

    print('patch 통신 실행 완료');

    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = {
      'statusCode': statusCode,
      'body': body,
    };
    print(body);

    print('상태코드');
    print(statusCode);

    if (statusCode == 401) {
      print('만료된 토큰');
      reissueToken();
    } else {
      return returnVal;
    }
  }

  reissueToken() async {
    var url = Uri.parse('$baseUrl/member-service/v1/members/reissue');
    print(userController.refreshToken);
    http.Response response = await http.post(
      url,
      headers: {
        // "Content-Type": "application/json",
        'REFRESH-TOKEN': userController.refreshToken,
        'Authorization': userController.accessToken,
      },
    );
    print('토큰 리이슈 Response');
    print(response.statusCode);
    print(response.headers);
    print(utf8.decode(response.bodyBytes));

    // userController.setAccessToken(resonse)
  }

  deleteRequest(apiUrl, parameter) async {
    var url = Uri.parse('$baseUrl$apiUrl');
    print(url);
    print(json.encode(parameter));
    http.Response response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': userController.accessToken
      },
      body: json.encode(parameter),
    );

    print('delete 통신 실행 완료');

    var statusCode = response.statusCode;
    var body = utf8.decode(response.bodyBytes);
    var returnVal = {
      'statusCode': statusCode,
      'body': body,
    };

    print('상태코드');
    print(statusCode);

    if (statusCode == 401) {
      print('만료된 토큰');
    } else {
      return returnVal;
    }
  }

  dioPostRequest(apiUrl, parameter, List<MultipartFile> multiPartFiles) async {
    var dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    dio.options.headers = {'Authorization': userController.accessToken};

    FormData formData = FormData.fromMap({
      'createCampaignRequest': MultipartFile.fromString(
          jsonEncode(parameter.toJson()),
          contentType: MediaType.parse('application/json')),
      'files': multiPartFiles
    });

    print(jsonEncode(parameter));
    print(multiPartFiles);

    var response = await dio.post('$baseUrl$apiUrl', data: formData);
    print('여기 바로 아래 뭐가 오나?');
    print(response.statusCode);
    print(response.statusMessage);
    print(response.data);

    if (response.statusCode == 401) {
      print('만료된 토큰');
      reissueToken();
    } else {
      return response;
    }
  }

  dioPutRequest(apiUrl, parameter, List<MultipartFile> multiPartFiles) async {
    var dio = Dio();
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

    var response = await dio.put('$baseUrl$apiUrl', data: formData);
    print('여기 바로 아래 뭐가 오나?');
    print(response.statusCode);
    print(response.statusMessage);
    print(response.data);
    return response;
  }

  dioPatchRequestSingleFile(apiUrl, File file) async {
    var dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    dio.options.maxRedirects.isFinite;
    dio.options.headers = {'Authorization': userController.accessToken};

    FormData formData = FormData.fromMap({
      'files': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('application', 'pdf'),
      )
    });

    print(file.path.split('/').last);
    print(file.path);

    var response = await dio.patch('$baseUrl$apiUrl', data: formData);
    print('여기 바로 아래 뭐가 오나?');
    print(response.statusCode);
    print(response.statusMessage);
    print(response.data);
    return response;
  }
}
