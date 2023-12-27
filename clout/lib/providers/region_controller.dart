import 'package:clout/type.dart';
import 'package:get/get.dart';

class RegionController extends GetxController {
  List<String?> selectedRegions = ['전체'];
  Map<String, String> enumString = {
    'ALL': '전체',
    'SEOUL': '서울',
    'BUSAN': '부산',
    'DAEGU': '대구',
    'INCHEON': '인천',
    'GWANGJU': '광주',
    'DAEJEON': '대전',
    'ULSAN': '울산',
    'SEJONG': '세종',
    'GYEONGGI': '경기',
    'GANGWON': '강원',
    'CHUNGBUK': '충북',
    'CHUNGNAM': '충남',
    'JEONBUK': '전북',
    'JEONNAM': '전남',
    'GYEONGBUK': '경북',
    'GYEONGNAM': '경남',
    'JEJU': '제주',
  };

  Map<String, String> stringEnum = {
    '전체': 'ALL',
    '서울': 'SEOUL',
    '부산': 'BUSAN',
    '대구': 'DAEGU',
    '인천': 'INCHEON',
    '광주': 'GWANGJU',
    '대전': 'DAEJEON',
    '울산': 'ULSAN',
    '세종': 'SEJONG',
    '경기': 'GYEONGGI',
    '강원': 'GANGWON',
    '충북': 'CHUNGBUK',
    '충남': 'CHUNGNAM',
    '전북': 'JEONBUK',
    '전남': 'JEONNAM',
    '경북': 'GYEONGBUK',
    '경남': 'GYEONGNAM',
    '제주': 'JEJU',
  };

  final List<RegionBool> regionsSelectedBool = [
    RegionBool("전체", true),
    RegionBool("서울", false),
    RegionBool("부산", false),
    RegionBool("대구", false),
    RegionBool("인천", false),
    RegionBool("광주", false),
    RegionBool("대전", false),
    RegionBool("울산", false),
    RegionBool("세종", false),
    RegionBool("경기", false),
    RegionBool("강원", false),
    RegionBool("충북", false),
    RegionBool("충남", false),
    RegionBool("전북", false),
    RegionBool("전남", false),
    RegionBool("경북", false),
    RegionBool("경남", false),
    RegionBool("제주", false),
  ];

  setSelectDeselect(index) {
    if (index == 0) {
      for (int i = 1; i < regionsSelectedBool.length; i++) {
        regionsSelectedBool[i].selected = false;
      }
      regionsSelectedBool[index].selected =
          !regionsSelectedBool[index].selected;
      if (regionsSelectedBool[index].selected) {
        selectedRegions = ['전체'];
      } else {
        selectedRegions = [];
      }
    } else {
      removeRegion('전체');
      regionsSelectedBool[0].selected = false;
      regionsSelectedBool[index].selected =
          !regionsSelectedBool[index].selected;
      if (regionsSelectedBool[index].selected) {
        selectedRegions.add(regionsSelectedBool[index].region);
      } else {
        selectedRegions.remove(regionsSelectedBool[index].region);
      }
    }
    update();
  }

  getEnum(input) {
    return stringEnum[input];
  }

  getString(input) {
    return enumString[input];
  }

  void setSelectedRegions(input) {
    selectedRegions = input;
    update();
  }

  void removeRegion(input) {
    selectedRegions.remove(input);
    update();
  }

  void addRegion(input) {
    selectedRegions.add(input);
    update();
  }
}
