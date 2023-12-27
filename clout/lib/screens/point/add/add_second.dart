import 'package:clout/hooks/apis/points_charge_api.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

// widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/point/widgets/main_text.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/screens/point/withdraw/widgets/bold_text.dart';
import 'package:clout/screens/point/withdraw/widgets/medium_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class AddSecond extends StatefulWidget {
  const AddSecond({super.key, this.bank, this.account});

  final String? bank;
  final String? account;

  @override
  State<AddSecond> createState() => _AddSecondState();
}

class _AddSecondState extends State<AddSecond> {
  TextEditingController pointController = TextEditingController();
  double amount = 0;
  int userPoints = 1; // 사용자 보유 포인트
  late dynamic args = Get.arguments;

  var f = NumberFormat('###,###,###,###');

  // Future<int> fetchUserPoints() async {
  //   //사용자 ID
  //   final userController = Get.find<UserController>();
  //   var memberId = userController.memberId;
  //   var authorization = userController.userLogin['authorization'];

  //   return 130000; // 임시로 130,000을 반환
  // }

  void addUserPoints() async {
    //사용자 ID
    final userController = Get.find<UserController>();
    var memberId = userController.memberId;
    var authorization = userController.userLogin['authorization'];

    //post할 내용

    var addParameter = {
        "memberId": memberId,
        "chargePoint": int.parse(pointController.text),
        "paymentType": "KAKAO",
    };

    //api에 전송
    final PointsChargeAPI pointsChargeAPI = PointsChargeAPI();
    pointsChargeAPI.postRequest(
      '/point-service/v1/points/charge', 
      authorization, 
      addParameter);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // API 호출하여 사용자의 보유 포인트를 가져오는 함수
    // fetchUserPoints().then((points) {
    //   setState(() {
    //     userPoints = points;
    //   });
    // });
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final nextMonth = now.add(Duration(days: 30)); // 다음 달로 이동
    final nextMonth15th = DateTime(nextMonth.year, nextMonth.month, 15);
    final formatter = DateFormat('MM월 dd일');

    return formatter.format(nextMonth15th);
  }

  movePage() {
    Get.offNamed("/addcomplete");
  }

  void _showModal() {
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              Icon(
                Icons.warning,
                size: 30,
                color: Colors.amber,
              ),
              SizedBox(height: 15),
              MediumText(text: '포인트 충전 후'),
              MediumText(text: '보유한 포인트는'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediumText(text: '현금으로'),
                  SizedBox(width: 5),
                  BoldText(text: '재환전이'),
                  SizedBox(width: 3),
                  Text('불가',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red)),
                  MediumText(text: '합니다.')
                ],
              ),
              SizedBox(height: 15),
              Text('포인트는 사용할 만큼만'),
              Text('충전하여 사용해주세요!'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: SizedBox(
                  height: 30,
                  width: 230,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: style.colors['category'],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      children: [
                        Icon(Icons.check, color: style.colors['main1']),
                        SizedBox(width: 3),
                        Text('내용을 확인했습니다.'),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 50,
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
                  SizedBox(
                    width: 140,
                    height: 50,
                    child: BigButton(
                      title: '충전하기',
                      function: (){
                        addUserPoints();
                        movePage();
                      },
                      //여기 function에 추가하고 싶다고
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(header: 4, headerTitle: '')),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: BouncingListview(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('${args['bank']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('계좌번호 : ${args['account']}',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                MainText(textTitle: '얼마를 충전할까요?'),
                SizedBox(height: 20),
                TextFormField(
                  controller: pointController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: '보낼금액 (원)',
                    labelStyle: TextStyle(
                        fontSize: 20, color: style.colors['lightgray']),
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: BigButton(
              title: '충전',
              function: () {
                if (pointController.text.isEmpty) {
                  Fluttertoast.showToast(msg: '금액을 입력해주세요.');}
                else {
                  if(int.parse(pointController.text)<1000){
                    Fluttertoast.showToast(msg: '1000원 이상만 충전 가능합니다.');
                  }
                  else{
                  _showModal();
                  }
                }
              }),
        ),
      ),
    );
  }
}
