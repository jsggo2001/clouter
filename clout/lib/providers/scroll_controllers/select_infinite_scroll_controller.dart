import 'package:clout/widgets/sns/sns4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// api
import 'dart:convert';
import 'dart:async';
import 'package:clout/type.dart';
import 'package:clout/hooks/apis/authorized_api.dart';

// widgets
import 'package:clout/screens/clouter_select/widgets/select_item_box.dart';

class SelectInfiniteScrollController extends GetxController {
  var scrollController = ScrollController().obs;

  List<dynamic> data = [].obs;

  int pageSize = 20;
  var isLoading = false;
  var hasMore = true;
  var currentPage = 0;
  var endPoint = '';
  var parameter = '';
  var campaignId = Get.arguments;

  int numberOfRecruiter = 0;
  int numberOfApplicants = 0;
  int numberOfSelectedMembers = 0;

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
    parameter = '?advertisementId=$campaignId&page=$currentPage&size=${10}';
    update();
  }

  setNumberOfRecruiter(input) {
    numberOfRecruiter = input;
    update();
  }

  setNumberOfApplicants(input) {
    numberOfApplicants = input;
    update();
  }

  setNumberOfSelectedMembers(input) {
    numberOfSelectedMembers = input;
    update();
  }

  Timer _timer = Timer(Duration(milliseconds: 3000), () {});
  @override
  void onInit() {
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore) {
        setCurrentPage(currentPage + 1);
        _getData();
      }
      if (scrollController.value.position.pixels < -100) {
        if (!_timer.isActive) {
          HapticFeedback.mediumImpact();
          reload();
          _timer = Timer(Duration(milliseconds: 3000), () {});
        }
      }
    });

    _getData();
    super.onInit();
  }

  _getData() async {
    isLoading = true;
    hasMore = true;

    await Future.delayed(Duration(seconds: 2));

    final AuthorizedApi authorizedApi = AuthorizedApi();
    print(parameter);
    var response = await authorizedApi.getRequest(
        '/advertisement-service/v1/applies/advertisers', parameter);

    var jsonData = jsonDecode(response['body']);
    var contentList = jsonData['content'] as List;
    print(contentList);
    var appendData = [];

    setNumberOfRecruiter(contentList[0]['numberOfRecruiter']);
    setNumberOfApplicants(contentList[0]['numberOfApplicants']);
    setNumberOfSelectedMembers(contentList[0]['numberOfSelectedMembers']);

    if (contentList.isNotEmpty) {
      for (var item in contentList) {
        var clouterInfo = AppliedClouterInfo.fromJson(item);

        var selectItemBox = Padding(
          padding: EdgeInsets.all(5),
          child: SelectItemBox(
            applyId: clouterInfo.applyId,
            clouterId: clouterInfo.clouterId,
            fee: clouterInfo.hopeAdFee,
            nickName: clouterInfo.nickname,
            starRating: clouterInfo.clouterAvgStar,
            selectedPlatform: clouterInfo.clouterChannelList
                    ?.map((channel) => Sns4(
                          platform: channel.platform,
                          followerScale: channel.followerScale,
                        ))
                    .toList() ??
                [],
          ),
        );
        appendData.add(selectItemBox);
      }
      data.addAll(appendData);

      isLoading = false;
      hasMore = contentList.isNotEmpty;
      update();
    } else {
      hasMore = false;
      isLoading = false;
      update();
    }
  }

  reload() async {
    isLoading = true;
    data.clear();

    await Future.delayed(Duration(seconds: 1));

    _getData();
    update();
  }
}
