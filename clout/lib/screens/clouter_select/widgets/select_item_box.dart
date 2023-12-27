import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// apis
import 'package:clout/hooks/apis/authorized_api.dart';
import 'dart:convert';

// controllers
import 'package:clout/providers/scroll_controllers/select_infinite_scroll_controller.dart';

// utilties
import 'package:clout/utilities/bouncing_listview.dart';

// widgets
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/buttons/small_button.dart';
import 'package:clout/widgets/common/custom_snackbar.dart';
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/screens/point/withdraw/widgets/medium_text.dart';

class SelectItemBox extends StatefulWidget {
  final int? applyId;
  final int? clouterId;
  final String? nickName;
  final int? starRating;
  final int? fee;
  final List<Widget>? selectedPlatform;
  // String? firstImg; // 💥 사진 추가

  const SelectItemBox(
      {super.key,
      this.applyId,
      this.clouterId,
      this.nickName,
      this.starRating,
      this.fee,
      this.selectedPlatform});

  @override
  State<SelectItemBox> createState() => _SelectItemBoxState();
}

class _SelectItemBoxState extends State<SelectItemBox> {
  var clouterId = Get.arguments;

  var f = NumberFormat('###,###,###,###');

  final AuthorizedApi authorizedApi = AuthorizedApi();

  @override
  initState() {
    _showContent();
    super.initState();
  }

  void _selectClouter() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 410,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.close,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              ),
              Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/clouterImage.jpg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.nickName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: style.colors['main1'])),
                      MediumText(text: ' 님을'),
                    ],
                  ),
                  MediumText(text: '클라우터로'),
                  MediumText(text: '채택할까요?'),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BigButton(
                            title: '아니요',
                            textColor: Colors.black,
                            buttonColor: style.colors['lightgray'],
                            function: () {
                              Get.back();
                            }),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 1,
                          child: BigButton(
                            title: '채택하기',
                            function: () {
                              selection();
                              Get.back();
                            },
                          )),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }

  // 채택 api
  selection() async {
    var requestBody = {
      "applyId": widget.applyId,
    };

    var response = await authorizedApi.postRequest(
        '/advertisement-service/v1/applies/${widget.applyId}/selection',
        requestBody);

    print(response);

    if (response['statusCode'] == 200) {
      print('클라우터 채택 성공~~ 🎉');
      final controller =
          Get.find<SelectInfiniteScrollController>(tag: 'clouterSelect');

      controller
          .setNumberOfSelectedMembers(controller.numberOfSelectedMembers + 1);
      CustomSnackbar(
              title: '🎉 클라우터 채택 완료!',
              message1: '클라우터에게 계약서가 전달되었어요. 😊',
              message2: '채택한 클라우터와 좋은 계약이 되길 바라요! 👍')
          .show();
    } else {
      print('클라우터 채택 실패.. 😥');
    }
  }

  // 채택 취소 api
  cancelSelection() async {
    var requestBody = {
      "applyId": widget.applyId,
    };

    var response = authorizedApi.postRequest(
        '/advertisement-service/v1/applies/${widget.applyId}/cancel',
        requestBody);

    if (response['statusCode'] == 200) {
      print('클라우터 채택 취소 성공~~ 🎉');
      final controller =
          Get.find<SelectInfiniteScrollController>(tag: 'clouterSelect');

      controller
          .setNumberOfSelectedMembers(controller.numberOfSelectedMembers - 1);

      CustomSnackbar(
              title: '클라우터 채택 취소 완료!',
              message1: '${widget.nickName} 님을 채택 취소했어요.',
              message2: '더 어울리는 클라우터를 찾길 바라요! 👍')
          .show();
    } else {
      print('클라우터 채택 취소 실패.. ❌');
    }
  }

  var message = '';
  int applyId = 0;

  // 한마디 보기 api
  Future<void> getData() async {
    final AuthorizedApi authorizedApi = AuthorizedApi();
    var response = await authorizedApi.getRequest(
        '/advertisement-service/v1/applies/', '${widget.applyId}/msg');

    var jsonData = jsonDecode(response['body']);

    setState(() {
      message = jsonData['message'];
      applyId = jsonData['applyId'];
    });
  }

  void _showContent() async {
    getData();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.close,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/clouterImage.jpg',
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(widget.nickName!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: style.colors['main1'])),
                              MediumText(text: ' 님의'),
                            ],
                          ),
                          MediumText(text: '한마디')
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: style.colors['lightgray']!,
                      ),
                    ),
                    height: 200,
                    child: SizedBox(
                      width: double.infinity,
                      child: BouncingListview(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on_outlined,
                          size: 20, color: style.colors['main1']),
                      Text(' 희망 광고비',
                          style: style.textTheme.headlineMedium?.copyWith(
                              color: style.colors['darkgray'],
                              fontWeight: FontWeight.w600)),
                      SizedBox(width: 20),
                      DataTitle(text: '${f.format(widget.fee)} 포인트'),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: BigButton(
                          title: '아니요',
                          textColor: Colors.black,
                          buttonColor: style.colors['lightgray'],
                          function: () {
                            Get.back();
                          }),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: BigButton(
                        title: '채택하기',
                        function: () {
                          Get.back();
                          _selectClouter();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> platformWidgets = [];

    if (widget.selectedPlatform != null) {
      for (var platformWidget in widget.selectedPlatform!) {
        platformWidgets.add(platformWidget);
        platformWidgets.add(SizedBox(width: 5));
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      double containerWidth = constraints.maxWidth;
      double imageWidth = containerWidth * 0.3;

      return InkWell(
        onTap: () => Get.toNamed('/clouterdetail', arguments: widget.clouterId),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          margin: EdgeInsets.only(bottom: 15),
          width: containerWidth,
          decoration: BoxDecoration(
            color: style.colors['white'],
            borderRadius: BorderRadius.circular(10),
            boxShadow: style.shadows['shadow'],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/clouterImage.jpg',
                      height: 100,
                      width: imageWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${widget.nickName}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                Text('${widget.starRating}'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('희망 광고비'),
                            Row(
                              children: [
                                Text('${f.format(widget.fee)} 포인트',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: style.colors['main1'],
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: platformWidgets,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SmallButton(
                      title: '한마디 보기',
                      function: () {
                        _showContent();
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: SmallButton(
                      title: '채택하기',
                      function: () {
                        _selectClouter();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
