import 'package:clout/hooks/apis/register_api.dart';
import 'package:clout/hooks/pictures/image_functions.dart';
import 'package:clout/providers/image_picker_controller.dart';
import 'package:clout/providers/user_controllers/clouter_controller.dart';
import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_2.dart';
import 'package:clout/type.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/common/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:clout/style.dart' as style;
import 'package:http_parser/http_parser.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_1.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_3.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_4.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

class ClouterJoin extends StatefulWidget {
  const ClouterJoin({super.key});

  @override
  ClouterJoinState createState() => ClouterJoinState();
}

class ClouterJoinState extends State<ClouterJoin> {
  int pageNum = 1;
  double percent = 1 / 4;

  // String baseUrl = dotenv.env['BASE_URL']!;

  final clouterController = Get.put(ClouterController());

  final registerController =
      Get.put(ClouterInfoController(), tag: 'clouterRegister');

  void goNext() {
    var validationMsg;
    if (pageNum == 1) {
      validationMsg = registerController.canGoSecondPage();
    } else if (pageNum == 2) {
      validationMsg = registerController.canGoThirdPage();
    } else if (pageNum == 3) {
      validationMsg = registerController.canGoFourthPage();
    }
    if (validationMsg == '') {
      setState(() {
        pageNum += 1;
        percent = pageNum / 4;
      });
    } else {
      Fluttertoast.showToast(msg: validationMsg);
    }
  }

  register() async {
    await registerController.setClouter();

    final imageController =
        Get.find<ImagePickerController>(tag: clouterController.controllerTag);

    ImageFunctions imageFunctions = ImageFunctions();

    var imageFiles =
        imageFunctions.pickedImagesToMultiPartFiles(imageController.images);

    RegisterApi registerApi = RegisterApi();

    // await을 안붙히면 Future<dynamic> 형식으로 넘어와서 데이터 처리하기 힘듦 => await을 붙히면 String으로 오더라고(항상 이런건지를 모르겠음)
    var responseBody = await registerApi.dioPostRequest(
        '/member-service/v1/clouters/signup',
        registerController.clouter,
        imageFiles);

    print(responseBody);
    CustomSnackbar(
            title: '🥳 회원 가입 완료!',
            message1: '가입을 진심으로 축하드려요',
            message2: '성공적인 광고 계약을 기원할게요 🙌')
        .show();
    Get.offAllNamed('/login');
  }

  @override
  void initState() {
    clouterController.setControllerTag('clouterRegister');
    registerController.runOtherControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 회원 가입도중 뒤로 갈 경우 사진을 담아뒀던 state가 만료될 수 있도록 초기화
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: double.infinity,
            child: BouncingListview(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Text('가입하고', style: style.textTheme.titleMedium),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Clout_Logo.png',
                                    width: 100,
                                  ),
                                  Text(' 와 함께',
                                      style: style.textTheme.titleMedium),
                                ],
                              ),
                              Text('매칭해요', style: style.textTheme.titleMedium),
                              SizedBox(height: 10),
                              LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                padding: EdgeInsets.zero,
                                percent: percent,
                                animateFromLastPercent: true,
                                lineHeight: 10,
                                backgroundColor: style.colors['category'],
                                progressColor: style.colors['main1'],
                                barRadius: Radius.circular(5),
                              ),
                              pageNum != 1
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          pageNum -= 1;
                                          percent = pageNum / 4;
                                        });
                                      },
                                      icon: Icon(Icons.arrow_back_outlined),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(children: [
                          //페이지별로 보여주기
                          if (pageNum == 1)
                            ClouterJoinOrModify1(
                              modifying: false,
                              controllerTag: 'clouterRegister',
                            ),
                          if (pageNum == 2)
                            ClouterJoinOrModify2(
                              modifying: false,
                              controllerTag: 'clouterRegister',
                            ),
                          if (pageNum == 3)
                            ClouterJoinOrModify3(
                              modifying: false,
                              controllerTag: 'clouterRegister',
                            ),
                          if (pageNum == 4)
                            ClouterJoinOrModify4(
                              modifying: false,
                              controllerTag: 'clouterRegister',
                            ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: BigButton(
                            title: pageNum == 4
                                ? '완료'
                                : '다음', // pageNum에 따라 버튼 텍스트 변경
                            function: () {
                              if (pageNum < 4) {
                                goNext();
                              } else {
                                register();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
