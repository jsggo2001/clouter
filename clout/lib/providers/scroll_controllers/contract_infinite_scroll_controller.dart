import 'dart:async';
import 'dart:convert';

import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/screens/contract_list/widgets/small_contract.dart';
import 'package:clout/type.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContractInfiniteScrollController extends GetxController {
  var scrollController = ScrollController().obs;

  var contract;
  List<Widget> data = [];
  int currentPage = 0;
  int size = 10; // 무한스크롤 한번당 받아올 데이터 개수
  var isLoading = true;
  var dataLoading = true;
  var hasMore = true;

  Timer _timer = Timer(Duration(milliseconds: 3000), () {});

  @override
  void onInit() {
    getData();
    scrollController.value.addListener(() {
      print(scrollController.value.position.pixels);
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore) {
        setCurrentPage(currentPage + 1);
        getData();
      }
      if (scrollController.value.position.pixels < -100) {
        if (!_timer.isActive) {
          HapticFeedback.mediumImpact();
          reload();
          _timer = Timer(Duration(milliseconds: 3000), () {});
        }
      }
    });

    super.onInit();
  }

  setCurrentPage(input) {
    currentPage = input;
    update();
  }

  setIsLoading(input) {
    isLoading = input;
    update();
  }

  setDataLoading(input) {
    dataLoading = input;
    update();
  }

  setHasMore(input) {
    hasMore = input;
    update();
  }

  setData(input) {
    data = input;
    update();
  }

  getData() async {
    await setDataLoading(true);
    await setHasMore(true);
    await Future.delayed(Duration(milliseconds: 700));
    AuthorizedApi authorizedApi = AuthorizedApi();
    UserController userController = Get.find<UserController>();

    List<Widget> appendData = [];

    var response;

    if (userController.memberType == -1) {
      // 클라우터일경우
      response = await authorizedApi.getRequest(
          '/contract-service/v1/contracts/clouter',
          '?page=$currentPage&size=$size&clouterId=${userController.memberId}');
    } else if (userController.memberType == 1) {
      response = await authorizedApi.getRequest(
          '/contract-service/v1/contracts/advertiser',
          '?page=$currentPage&size=$size&advertiserId=${userController.memberId}');
    }

    print(response['statusCode']);
    var statusCode = response['statusCode'];
    var decodedResponse = jsonDecode(response['body']);
    print(decodedResponse);
    if (statusCode == 200) {
      if (ContractResponse.fromJson(decodedResponse).content!.isNotEmpty) {
        for (var eachData
            in ContractResponse.fromJson(decodedResponse).content!) {
          print(eachData);
          var content = ContractContent.fromJson(eachData);
          appendData.add(SmallContract(
              name: content.name!,
              pay: content.price.toString(),
              progress: content.state! == 'WAITING' ? false : true,
              contractId: content.contractId!));
        }
        data.addAll(appendData);
        dataLoading = false;
        isLoading = false;
        update();
      } else {
        dataLoading = false;
        hasMore = false;
        isLoading = false;
        update();
      }
    } else {
      dataLoading = false;
      hasMore = false;
      isLoading = false;
      update();
      print('에러');
      print(decodedResponse);
    }
  }

  reload() async {
    await setIsLoading(true);
    await setDataLoading(true);
    await setHasMore(true);
    await setCurrentPage(0);
    await Future.delayed(Duration(milliseconds: 300));
    data = [];
    update();
    getData();
  }
}
