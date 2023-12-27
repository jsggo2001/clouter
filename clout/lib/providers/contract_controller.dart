import 'dart:convert';
import 'dart:io';
import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/screens/contract_list/utilities/save_file_mobile.dart';
import 'package:clout/screens/pdf_viewer/pdf_viewer.dart';
import 'package:clout/type.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:dio/dio.dart';

class ContractController extends GetxController {
  Contract? contractInfo;

  var frontNumber;
  var backNumber;
  var isBlank = true;
  var signature;
  var contractFile;

  AuthorizedApi authorizedApi = AuthorizedApi();
  loadContractData(input) async {
    var response = await authorizedApi.getRequest(
        '/contract-service/v1/contracts/', input);
    print(response);
    final decodedResponse = jsonDecode(response['body']);
    contractInfo = Contract.fromJson(decodedResponse);
  }

  loadContractFile(input) async {
    var response = await authorizedApi.getRequest(
        '/contract-service/v1/contracts/file/', input);
    print(response);
    print('여까지 오냐?');
    // Get.to(() => PdfViewer(pdfUrl: response['body']));
    var pdfUrl = response['body'];
    Dio dio = Dio();

    try {
      // PDF 파일을 다운로드 받기 위한 GET 요청
      var response = await dio.get(
        pdfUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // 임시 저장소 할당
      Directory directory =
          await path_provider.getApplicationSupportDirectory();
      String path = directory.path;

      // pdf 파일 다운로드 후 저장
      File file = File('$path/광고계약서.pdf');
      await file.writeAsBytes(response.data, flush: true);

      // pdf 파일 실행
      await open_file.OpenFile.open(file.path);
    } catch (e) {
      print('파일 다운로드 실패: $e');
    }
  }

  setResidentRegistrationNumber() {
    contractInfo!.clouterInfo!.residentRegistrationNumber =
        '$frontNumber - $backNumber';
    update();
  }

  setFrontNumber(input) {
    frontNumber = input;
    update();
  }

  setBackNumber(input) {
    backNumber = input;
    update();
  }

  setBlank(input) {
    isBlank = input;
    update();
  }

  setSignature(input) {
    signature = input;
    update();
  }

  setContractFile(input) {
    contractFile = input;
    update();
  }
}
