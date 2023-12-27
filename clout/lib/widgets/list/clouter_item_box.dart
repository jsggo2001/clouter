import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';

// utilities
import 'package:clout/utilities/category_translator.dart';

// widgets
import 'package:clout/widgets/buttons/like_button.dart';
import 'package:clout/widgets/common/nametag.dart';
import 'package:clout/widgets/sns/sns2.dart';

class ClouterItemBox extends StatefulWidget {
  final int clouterId;
  final String userId;
  final String nickName;
  final int avgScore;
  final int minCost;
  final List<dynamic> categoryList;
  final int countOfContract;
  final List<Widget> adPlatformList;
  final String? firstImg; // 💥 사진 나중에 추가하기

  ClouterItemBox(
      {super.key,
      required this.clouterId,
      required this.userId,
      required this.nickName,
      required this.avgScore,
      required this.minCost,
      required this.categoryList,
      required this.countOfContract,
      required this.adPlatformList,
      this.firstImg});

  @override
  State<ClouterItemBox> createState() => _ClouterItemBoxState();
}

class _ClouterItemBoxState extends State<ClouterItemBox> {
  var f = NumberFormat('###,###,###,###');

  bool isItemLiked = false;

  void handleItemTap() {
    setState(() {
      isItemLiked = !isItemLiked;
    });
  }

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 'ALL'이 포함되어 있으면 모든 플랫폼에 대한 위젯 리스트 생성
    // List<Widget> adPlatformWidgets;
    // if (widget.adPlatformList
    //     .any((widget) => widget is Sns2 && widget.platform == "ALL")) {
    //   adPlatformWidgets = ["INSTAGRAM", "TIKTOK", "YOUTUBE"]
    //       .map((platform) => Sns2(platform: platform))
    //       .toList();
    // } else {
    //   // 'ALL'이 없으면 기존 리스트를 사용
    //   adPlatformWidgets = widget.adPlatformList;
    // }
    return InkWell(
      onTap: () => Get.toNamed('/clouterdetail', arguments: widget.clouterId),
      child: Container(
        width: screenWidth / 2 - 25,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: style.colors['white'],
          borderRadius: BorderRadius.circular(10),
          boxShadow: style.shadows['shadow'],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                // 제일 큰 이미지
                widget.firstImg != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          widget.firstImg!,
                          width: screenWidth / 2 - 40,
                          height: screenHeight / 2 - 270,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset(
                          'assets/images/blank-profile.png',
                          width: screenWidth / 2 - 40,
                          height: screenHeight / 2 - 270,
                          fit: BoxFit.fill,
                        ),
                      ),
                // 이미지에 떠있는 플랫폼 이미지
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: style.colors['white'],
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(children: widget.adPlatformList),
                  ),
                ),
                // if (userController.memberType == 1)
                // LikeButton(isLiked: isItemLiked, onTap: handleItemTap),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.categoryList
                    .map((category) => NameTag(
                        title:
                            AdCategoryTranslator.translateAdCategory(category)))
                    .toList(),
              ),
            ),
            Text(
              widget.nickName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: screenWidth > 400 ? 17 : 15,
              ),
            ),
            Text(
              '${f.format(widget.minCost)} 포인트',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: style.colors['main1'],
                fontWeight: FontWeight.w500,
                fontSize: screenWidth > 400 ? 17 : 15,
              ),
            ),
            Row(
              children: [
                Text(
                  '계약한 광고 수 : ',
                  style: TextStyle(
                    fontSize: screenWidth > 400 ? 15 : 13,
                  ),
                ),
                Text(
                  '${widget.countOfContract}건', // 💥 계약한 광고 수
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth > 400 ? 15 : 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
