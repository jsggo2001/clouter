import 'package:clout/screens/mypage/widgets/selected_category.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/common/choicechip.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:clout/hooks/apis/points_transactions.dart';
import 'dart:convert';

// widgets
import 'package:clout/screens/point/widgets/my_wallet.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/point/widgets/point_item_box.dart';

class AdvertiserPointList extends StatefulWidget {
  const AdvertiserPointList({Key? key}) : super(key: key);

  @override
  State<AdvertiserPointList> createState() => _AdvertiserPointListState();
}

class _AdvertiserPointListState extends State<AdvertiserPointList> {
  final userController = Get.find<UserController>();
  String selectedCategory = 'ALL';

  @override
  void initState() {
    super.initState();
    // initState에서 비동기 작업 수행
    // 이 부분은 비동기로 데이터를 가져오기 위해 사용합니다.
    // FutureBuilder를 사용하여 비동기 작업이 완료될 때까지 기다리고 결과를 표시합니다.
  }

  Future<List<Widget>> getPointList() async {
    var authorization = userController.userLogin['authorization'];
    print('포인트리스트');
    print(userController.userLogin);
    var requestBody = {
      "memberId": userController.memberId,
      "category": selectedCategory,
      "page": '0',
      "size": '10',
    };

    var response = await PointsTransactionsApi.getRequest(
      '/point-service/v1/points/transactions',
      authorization,
      requestBody,
    );

    print('$requestBody');
    var responseData = json.decode(response);
    var contentList = responseData['content'];

    List<Widget> pointItemBoxes = [];

    for (var item in contentList) {
      var pointStatus = item['pointStatus'];
      var time = item['time'].substring(0, 10); // Extract date only
      var title = item['counterparty'];
      var amount = item['amount'];

      var type = (pointStatus == '+') ? '충전' : '사용';

      pointItemBoxes.add(PointItemBox(
        type: type,
        time: time,
        title: title,
        point: amount,
      ));
    }

    return pointItemBoxes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 4,
          headerTitle: '포인트 관리',
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: BouncingListview(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.9,
            child: Column(
              children: [
                MyWallet(userType: "advertiser"),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '포인트 내역',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  ),
                ),
                ActionChoiceExample(
                  labels: ['전체 내역', '거래 내역', '충전 내역'],
                  chipCount: 3,
                  onChipSelected: (label) {
                    setState(() {
                      switch (label) {
                        case '전체 내역':
                          selectedCategory = 'ALL';
                          break;
                        case '거래 내역':
                          selectedCategory = 'DEAL';
                          break;
                        case '충전 내역':
                          selectedCategory = 'CHARGE';
                          break;
                      }
                    });
                  },
                ),
                Divider(
                  color: style.colors['lightgray'],
                  thickness: 1,
                ),
                // Replace static PointItemBox with dynamically generated ones
                FutureBuilder(
                  future: getPointList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    } else if (snapshot.hasError) {
                      return Text('에러: ${snapshot.error}');
                    } else {
                      List<Widget> pointItemBoxes = snapshot.data ?? [];
                      return Column(children: pointItemBoxes);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
