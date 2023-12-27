import 'dart:io';
import 'dart:typed_data';

import 'package:clout/type.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http hide MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageFunctions {
  // 이미지 url 이용해서 xfile 반환해주는 함수
  imageUrlToXFile(List<dynamic> urls) async {
    List<XFile> images = [];
    for (int i = 0; i < urls.length; i++) {
      var filePath = ImageResponse.fromJson(urls[i]).path;
      http.Response responseData = await http.get(Uri.parse(filePath!));
      var uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/img$i').writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      XFile result = XFile(file.path);

      images.add(result);
    }
    return images;
  }

  // 이미지 픽한거 서버에 전송할 수 있는 형태로 변환해주는 함수(여러개)
  // List<dio.MultipartFile> pickedImagesToMultiPartFiles(input) async {
  List<MultipartFile> pickedImagesToMultiPartFiles(input) {
    List<MultipartFile> imageFiles = [];
    for (int i = 0; i < input.length; i++) {
      String imagePath = input[i].path;
      String fileType =
          imagePath.substring(imagePath.lastIndexOf('.') + 1, imagePath.length);
      imageFiles.add(MultipartFile.fromFileSync(imagePath,
          contentType: MediaType(
              'image', fileType.toLowerCase(), {'charset': 'utf-8'})));
    }
    return imageFiles;
  }

  // 이미지 픽한거 서버에 전송할 수 있는 형태로 변환해주는 함수(한 개)
  MultipartFile pickedImageToMultiPartFiles(input) {
    String imagePath = input.path;
    String fileType =
        imagePath.substring(imagePath.lastIndexOf('.') + 1, imagePath.length);
    final imageFile = MultipartFile.fromFileSync(imagePath,
        contentType:
            MediaType('image', fileType.toLowerCase(), {'charset': 'utf-8'}));
    return imageFile;
  }
}
