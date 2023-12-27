import 'dart:io';
import 'dart:typed_data';

import 'package:clout/hooks/pictures/image_functions.dart';
import 'package:clout/providers/address_controller.dart';
import 'package:clout/providers/date_input_controller.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:clout/providers/image_picker_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/providers/region_controller.dart';
import 'package:clout/providers/user_controllers/clouter_controller.dart';
import 'package:clout/type.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ClouterInfoController extends GetxController {
  var name;
  var age;
  var phoneNumber;
  var id;
  var password;
  var checkPassword;
  var nickName;
  var images;
  var negoable;
  List<bool> selections = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  var doubleId = 0;
  var obscured = true;
  // var negoable = true;

  var clouter;

  static List<String> categories = [
    'ALL',
    'FASHION_BEAUTY',
    'HEALTH_LIFESTYLE',
    'TRAVEL_LEISURE',
    'PARENTING',
    'ELECTRONICS',
    'FOOD',
    'VISIT_EXPERIENCE',
    'PETS',
    'GAMES',
    'ECONOMY_BUSINESS',
    'OTHERS'
  ];

  static Map<String, int> categoryToIndex = {
    'ALL': 0,
    'FASHION_BEAUTY': 1,
    'HEALTH_LIFESTYLE': 2,
    'TRAVEL_LEISURE': 3,
    'PARENTING': 4,
    'ELECTRONICS': 5,
    'FOOD': 6,
    'VISIT_EXPERIENCE': 7,
    'PETS': 8,
    'GAMES': 9,
    'ECONOMY_BUSINESS': 10,
    'OTHERS': 11,
  };

  final clouterController = Get.find<ClouterController>();
  var fourDigitsInputController;
  var addressController;
  var platformSelectController;
  var followerController;
  var feeController;
  var regionController;
  var dateController;
  var imagePickerController;

  // getImageXFileByUrl(List<dynamic> urls) async {
  //   List<XFile> returnVal = [];
  //   for (int i = 0; i < urls.length; i++) {
  //     // File imageFile = File(urls[i].path!);
  //     var filePath = ImageResponse.fromJson(urls[i]).path;
  //     http.Response responseData = await http.get(Uri.parse(filePath!));
  //     var uint8list = responseData.bodyBytes;
  //     var buffer = uint8list.buffer;
  //     ByteData byteData = ByteData.view(buffer);
  //     var tempDir = await getTemporaryDirectory();

  //     File file = await File('${tempDir.path}/img$i').writeAsBytes(
  //         buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //     XFile result = XFile(file.path);

  //     // XFile result = XFile(ImageResponse.fromJson(urls[i]).path!);
  //     returnVal.add(result);
  //   }
  //   return returnVal;
  // }

  loadBeforeModify(Clouter input) async {
    print(input.name);
    print(input.channelList);
    print(input.address);
    print(input.age);
    print(input.birthday);
    print(input.minCost);
    print(input.phoneNumber);

    setId(input.userId);
    setNickName(input.nickName);
    setName(input.name);
    setAge(input.age);
    dateController.setSelectedDateDirectly(DateTime.parse(input.birthday!));
    setPhoneNumber(input.phoneNumber);
    addressController.setZipCode(input.address!.zipCode);
    addressController.setDaumAddress(input.address!.mainAddress);
    addressController.setDetailAddress(input.address!.detailAddress);
    fourDigitsInputController.setPhoneVerified(true);
    print('여기까지 옴1');
    ImageFunctions imageFunctions = ImageFunctions();
    var images = await imageFunctions.imageUrlToXFile(input.imageResponses!);
    await imagePickerController.addImage(images);
    print('여기까지 옴2');
    print(images);

    var channelList = input.channelList!;
    for (int i = 0; i < channelList.length; i++) {
      var platformIndex;

      if (channelList[i]['platform'] == 'INSTAGRAM') {
        platformIndex = 0;
      } else if (channelList[i]['platform'] == 'TIKTOK') {
        platformIndex = 1;
      } else {
        platformIndex = 2;
      }

      platformSelectController.setSelected(platformIndex, true);
      platformSelectController.setId(platformIndex, channelList[i]['name']);
      platformSelectController.setLink(platformIndex, channelList[i]['link']);
      platformSelectController.setFollowerCount(
          platformIndex, channelList[i]['followerScale'].toString());
    }

    feeController.setPay(input.minCost.toString());
    selections[0] = false;
    for (int i = 0; i < input.categoryList!.length; i++) {
      selections[categoryToIndex[input.categoryList![i]]!] = true;
    }

    List<String> newRegionList = [];
    for (int i = 0; i < input.regionList!.length; i++) {
      newRegionList.add(regionController.getString(input.regionList![i]));
    }
    regionController.setSelectedRegions(newRegionList);
    update();
  }

  runOtherControllers() {
    fourDigitsInputController = Get.put(
      FourDigitsInputController(),
      tag: clouterController.controllerTag,
    );
    addressController = Get.put(
      AddressController(),
      tag: clouterController.controllerTag,
    );
    platformSelectController = Get.put(
      PlatformSelectController(),
      tag: clouterController.controllerTag,
    );
    followerController = Get.put(
      FollowerController(),
      tag: clouterController.controllerTag,
    );
    feeController = Get.put(
      FeeController(),
      tag: clouterController.controllerTag,
    );
    regionController = Get.put(
      RegionController(),
      tag: clouterController.controllerTag,
    );
    dateController = Get.put(
      DateInputController(),
      tag: clouterController.controllerTag,
    );
    imagePickerController = Get.put(
      ImagePickerController(),
      tag: clouterController.controllerTag,
    );
    update();
  }

  setClouter() {
    List<ChannelList> channelList = [];
    for (int i = 0; i < 3; i++) {
      if (platformSelectController!.id[i].length > 0) {
        final channel = ChannelList(
            platformSelectController!.id[i],
            i == 0
                ? 'INSTAGRAM'
                : i == 1
                    ? 'TIKTOK'
                    : 'YOUTUBE',
            platformSelectController!.link[i],
            int.parse(platformSelectController!.followerCount[i]));
        channelList.add(channel);
      }
    }

    print(channelList);

    List<String> categoryList = [];
    for (int i = 0; i < 12; i++) {
      if (selections[i]) {
        categoryList.add(categories[i]);
      }
    }

    List<String> regionList = [];
    for (int i = 0; i < regionController.selectedRegions.length; i++) {
      regionList
          .add(regionController.getEnum(regionController.selectedRegions[i]));
    }

    Address address = Address(
      addressController!.zipCode,
      addressController!.daumAddress,
      addressController!.detailAddress,
    );

    clouter = Clouter(
        userId: id,
        pwd: password,
        nickName: nickName,
        name: name,
        birthday: DateFormat('yyyy-MM-dd').format(dateController!.selectedDate),
        age: dateController.age,
        phoneNumber: phoneNumber,
        channelList: channelList,
        minCost: int.parse(feeController!.pay),
        categoryList: categoryList,
        regionList: regionList,
        address: address,);
    update();
  }

  setName(input) {
    name = input;
    print(name);
    update();
  }

  setPhoneNumber(input) {
    phoneNumber = input;
    update();
  }

  setId(input) {
    id = input;
    update();
  }

  setPassword(input) {
    password = input;
    update();
  }

  setCheckPassword(input) {
    checkPassword = input;
    update();
  }

  setNickName(input) {
    nickName = input;
    print(nickName);
    update();
  }

  setAge(input) {
    age = input;
    update();
  }

  setSelection(index) {
    if (index == 0) {
      selections = List.generate(12, (index) => false);
      selections[index] = !selections[index];
    } else {
      selections[0] = false;
      selections[index] = !selections[index];
    }
    update();
  }

  setDoubleId(input) {
    //defulat 0
    //가능하면 1
    //중복이면 2
    //지금은 편의상 중복 아니라고 함
    doubleId = input;
    update();
  }

  setObscured() {
    obscured = !obscured;
    update();
  }

  canGoSecondPage() {
    if (name == null || name.length == 0) {
      return '이름을 입력해주세요';
    }
    if (DateFormat('yyyy.MM.dd').format(dateController!.selectedDate) ==
        DateFormat('yyyy.MM.dd').format(DateTime.now())) {
      return '생년월일을 입력해주세요 🎂';
    }
    if (phoneNumber == null || phoneNumber.length == 0) {
      return '휴대전화 번호를 입력해주세요 📱';
    }
    if (!fourDigitsInputController.phoneVerified) {
      return '휴대전화 번호 인증을 진행해주세요';
    }
    if (addressController.zipCode == null ||
        addressController.zipCode.length == 0) {
      return '주소를 입력해주세요 🏢';
    }
    if (addressController.detailAddress == null ||
        addressController.detailAddress.length == 0) {
      return '상세주소를 입력해주세요 🏠';
    }
    return '';
  }

  canGoThirdPage() {
    if (nickName == null || nickName.length == 0) {
      return '닉네임을 입력해주세요';
    }
    if (id == null || id.length == 0) {
      return '아이디를 입력해주세요 📃';
    }
    if (id.length < 5 || id.length > 15) {
      return '아이디는 5자 ~ 15자로 입력해주세요';
    }
    if (doubleId == 0) {
      return '아이디 중복을 확인해주세요';
    }
    if (doubleId == 2) {
      return '중복된 아이디입니다 😥';
    }
    if (password == null || password.length == 0) {
      return '비밀번호를 입력해주세요';
    }
    if (password.length < 8 || password.length > 20) {
      return '비밀번호는 8자 ~ 20자로 입력해주세요';
    }
    if (checkPassword == null || checkPassword.length == 0) {
      return '비밀번호 확인을 입력해주세요';
    }
    if (checkPassword != password) {
      return '비밀번호 확인이 일치하지 않습니다';
    }
    return '';
  }

  canGoFourthPage() {
    print(platformSelectController.platforms);
    print(platformSelectController.id);
    print(platformSelectController.link);
    print(platformSelectController.followerCount);
    if ((platformSelectController.id[0].length == 0 &&
            platformSelectController.link[0].length == 0 &&
            platformSelectController.followerCount[0] == '0') &&
        (platformSelectController.id[1].length == 0 &&
            platformSelectController.link[1].length == 0 &&
            platformSelectController.followerCount[1] == '0') &&
        (platformSelectController.id[2].length == 0 &&
            platformSelectController.link[2].length == 0 &&
            platformSelectController.followerCount[2] == '0')) {
      return '최소 한개 이상의 SNS 정보를 입력해주세요';
    }
    if (platformSelectController.id[0].length != 0 ||
        platformSelectController.link[0].length != 0 ||
        platformSelectController.followerCount[0] != '0') {
      if (platformSelectController.id[0].length == 0 ||
          platformSelectController.link[0].length == 0 ||
          platformSelectController.followerCount[0] == '0') {
        return 'Instagram 계정의 정보를 완성해주세요';
      }
    }
    if (platformSelectController.id[1].length != 0 ||
        platformSelectController.link[1].length != 0 ||
        platformSelectController.followerCount[1] != '0') {
      if (platformSelectController.id[1].length == 0 ||
          platformSelectController.link[1].length == 0 ||
          platformSelectController.followerCount[1] == '0') {
        return 'Tiktok 계정의 정보를 완성해주세요';
      }
    }
    if (platformSelectController.id[2].length != 0 ||
        platformSelectController.link[2].length != 0 ||
        platformSelectController.followerCount[2] != '0') {
      if (platformSelectController.id[2].length == 0 ||
          platformSelectController.link[2].length == 0 ||
          platformSelectController.followerCount[2] == '0') {
        return 'Youtube 계정의 정보를 완성해주세요';
      }
    }
    return '';
  }
}
