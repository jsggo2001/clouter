import 'package:clout/providers/address_controller.dart';
import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:clout/providers/user_controllers/advertiser_controller.dart';
import 'package:clout/type.dart';
import 'package:get/get.dart';

class AdvertiserInfoController extends GetxController {
  var name;
  var phoneNumber;
  var id;
  var doubleId = 0;
  var password;
  var checkPassword;
  var businessName;
  var headName;
  var businessNumber;
  var obscured = true;

  var advertiser;

  final advertiserController = Get.find<AdvertiserController>();

  var addressController;
  var fourDigitsInputController;

  runOtherControllers() {
    addressController = Get.put(
      AddressController(),
      tag: advertiserController.controllerTag,
    );
    fourDigitsInputController = Get.put(
      FourDigitsInputController(),
      tag: advertiserController.controllerTag,
    );
  }

  loadBeforeModify(Advertiser input) {
    setName(input.companyInfo!.managerName);
    setPhoneNumber(input.companyInfo!.managerPhoneNumber);
    setId(input.userId);
    setBusinessName(input.companyInfo!.companyName);
    setHeadName(input.companyInfo!.ceoName);
    setBusinessNumber(input.companyInfo!.regNum);
    addressController!.setZipCode(input.address!.zipCode);
    addressController!.setDaumAddress(input.address!.mainAddress);
    addressController!.setDetailAddress(input.address!.detailAddress);
    fourDigitsInputController.setPhoneVerified(true);
    update();
  }

  setAdvertiser() {
    advertiser = Advertiser(
      id,
      password,
      Address(addressController!.zipCode, addressController!.daumAddress,
          addressController!.detailAddress),
      CompanyInfo(businessName, businessNumber, headName, name, phoneNumber),
      null,
    );
    update();
  }

  setName(input) {
    name = input;
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

  setDoubleId(input) {
    //가능하면 1
    //중복이면 2
    //지금은 편의상 중복 아니라고 함
    doubleId = input;
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

  setBusinessName(input) {
    businessName = input;
    update();
  }

  setHeadName(input) {
    headName = input;
    update();
  }

  setBusinessNumber(input) {
    businessNumber = input;
    update();
  }

  setObscured() {
    obscured = !obscured;
    update();
  }

  canGoSecondPage() {
    if (businessName == null || businessName.length == 0) {
      return '업체명을 입력해주세요 🏢';
    }
    if (headName == null || headName.length == 0) {
      return '대표 이름을 입력해주세요 😎';
    }
    if (businessNumber == null || businessNumber.length == 0) {
      return '사업자등록번호를 입력해주세요 📃';
    }
    if (businessNumber.length != 12) {
      return '사업자등록번호를 확인해주세요 📃';
    }
    if (addressController!.zipCode == null ||
        addressController!.zipCode.length == 0) {
      return '주소를 입력해주세요 🏢';
    }
    if (addressController!.detailAddress == null ||
        addressController!.detailAddress.length == 0) {
      return '상세주소를 입력해주세요 🏠';
    }
    return '';
  }

  canRegister() {
    if (name == null || name.length == 0) {
      return '담당자 이름을 입력해주세요 👩';
    }
    if (phoneNumber == null || phoneNumber.length == 0) {
      return '담당자 휴대전화 번호를 입력해주세요 📱';
    }
    // 휴대전화 인증 여부
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
      return '비밀번호는 8자 ~ 20자로 입력헤주세요';
    }
    if (checkPassword == null || checkPassword.length == 0) {
      return '비밀번호 확인을 입력해주세요';
    }
    if (password != checkPassword) {
      return '비밀번호 확인이 일치하지 않습니다.';
    }
    return '';
  }

  printAll() {
    print('아이디');
    print(advertiser?.userId);
    print('비밀번호');
    print(advertiser?.pwd);
    print('지역코드');
    print(advertiser?.address.zipCode);
    print('소재지');
    print(advertiser?.address.mainAddress);
    print('상세주소');
    print(advertiser?.address.detailAddress);
    print('회사 이름');
    print(advertiser?.companyInfo.companyName);
    print('대표 이름');
    print(advertiser?.companyInfo.ceoName);
    print('사업자등록번호');
    print(advertiser?.companyInfo.regNum);
    print('담당자 이름');
    print(advertiser?.companyInfo.managerName);
    print('담당자 폰번호');
    print(advertiser?.companyInfo.managerPhoneNumber);
  }
}
