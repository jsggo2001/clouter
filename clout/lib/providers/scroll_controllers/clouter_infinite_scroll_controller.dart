import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// api
import 'dart:convert';
import 'dart:async';
import 'package:clout/type.dart';
import 'package:clout/hooks/apis/authorized_api.dart';

// widgets
import 'package:clout/widgets/sns/sns2.dart';
import 'package:clout/widgets/list/clouter_item_box.dart';

class ClouterInfiniteScrollController extends GetxController {
  var scrollController = ScrollController().obs;

  List<dynamic> data = [].obs;

  int pageSize = 20;
  var isLoading = true;
  var dataLoading = true;
  var hasMore = true;
  var currentPage = 0;
  var endPoint = '';
  var parameter = '';

  setEndPoint(input) {
    endPoint = input;
    update();
  }

  setParameter(input) {
    parameter = input;
    update();
  }

  setCurrentPage(input) {
    currentPage = input;
    update();
  }

  setIsLoading(input) {
    isLoading = input;
    update();
  }

  Timer _timer = Timer(Duration(milliseconds: 3000), () {});

  @override
  void onInit() {
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

  getData() async {
    try {
      isLoading = true;
      hasMore = true;
      await setEndPoint(
          '/member-service/v1/clouters/search?page=${currentPage}&size=${10}&');
      await Future.delayed(Duration(seconds: 2));

      final AuthorizedApi authorizedApi = AuthorizedApi();

      var response = await authorizedApi.getRequest(endPoint, parameter);
      print(response);
      var jsonData = jsonDecode(response['body']);
      var contentList = jsonData['content'] as List;

      var appendData = [];

      if (contentList.isNotEmpty) {
        for (var item in contentList) {
          var clouterInfo = ClouterInfo.fromJson(item);

          var clouterItemBox = Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClouterItemBox(
              clouterId: clouterInfo.clouterId!,
              userId: clouterInfo.userId!,
              nickName: clouterInfo.nickName!,
              avgScore: clouterInfo.avgScore ?? 0,
              minCost: clouterInfo.minCost ?? 0,
              categoryList: clouterInfo.categoryList!,
              adPlatformList: clouterInfo.channelList
                      ?.map((channel) => Sns2(platform: channel.platform))
                      .toList() ??
                  [],
              countOfContract: clouterInfo.countOfContract ?? 0,
              firstImg: clouterInfo.imageResponses != null &&
                      clouterInfo.imageResponses!.isNotEmpty
                  ? ImageResponse.fromJson(clouterInfo.imageResponses?[0]).path
                  : '',
            ),
          );
          appendData.add(clouterItemBox);
        }
        data.addAll(appendData);
        dataLoading = false;
        isLoading = false;
        update();
      } else {
        dataLoading = false;
        isLoading = false;
        hasMore = false;
        update();
      }
    } catch (e) {
      print('오류발생');
      isLoading = false;
      dataLoading = false;
      hasMore = false;
      update();
      print(e);
    }
  }

  reload() async {
    await setIsLoading(true);
    dataLoading = true;
    hasMore = true;
    data.clear();
    update();
    await setCurrentPage(0);
    await Future.delayed(Duration(milliseconds: 100));

    await getData();
  }
}
