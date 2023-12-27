import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clout/style.dart' as style;
import 'package:clout/type.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';

// widgets
import 'package:clout/widgets/buttons/like_button.dart';
import 'package:get/get.dart';
import 'package:clout/widgets/common/nametag.dart';
import 'package:clout/widgets/sns/sns2.dart';

class CampaignItemBox extends StatefulWidget {
  int? campaignId;
  String? adCategory;
  String? title;
  int? price;
  CompanyInfo? companyInfo;
  int? numberOfSelectedMembers;
  int? numberOfRecruiter;
  List<Widget>? adPlatformList;
  AdvertiserInfo? advertiserInfo;
  String? firstImg;
  int? applyId;
  String? companyName;
  int? advertiserAvgStar;

  // String? type;
  // ApplyContent? applyContent; != null
  // CampaignInfo? campaignInfo;
  // AdvertiserInf? advertiserInfo;
  // List<dynamic> imageList;

  CampaignItemBox({
    super.key,
    this.campaignId,
    this.adCategory,
    this.title,
    this.price,
    this.companyInfo,
    this.numberOfSelectedMembers,
    this.numberOfRecruiter,
    this.adPlatformList,
    this.advertiserInfo,
    this.firstImg,
    this.applyId,
    this.companyName,
    this.advertiserAvgStar,
  });

  @override
  State<CampaignItemBox> createState() => _CampaignItemBoxState();
}

class _CampaignItemBoxState extends State<CampaignItemBox> {
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

    return InkWell(
        // 여기 arguments에 해당 캠페인의 id를 넣어야 함
        onTap: () =>
            Get.toNamed('/campaignDetail', arguments: widget.campaignId),
        child: Container(
          width: screenWidth / 2 - 25,
          // height: screenHeight/2 - 160,
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
                  widget.firstImg != null && widget.firstImg != ''
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
                            'assets/images/blank-product.jpg',
                            width: screenWidth / 2 - 40,
                            height: screenHeight / 2 - 270,
                            fit: BoxFit.fill,
                          ),
                        ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: style.colors['white'],
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(children: widget.adPlatformList!),
                    ),
                  ),
                  // if (userController.memberType == -1)
                  //   LikeButton(isLiked: isItemLiked, onTap: handleItemTap),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NameTag(title: widget.adCategory!),
                  Text(
                      '${widget.numberOfSelectedMembers}명 / ${widget.numberOfRecruiter}명',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                ],
              ),
              Text(widget.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth > 400 ? 17 : 15,
                  )),
              Text(
                  widget.price != 0
                      ? '${f.format(widget.price)} 포인트'
                      : '포인트 없음',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: style.colors['main1'],
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth > 400 ? 17 : 15,
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                        widget.companyInfo?.companyName ?? widget.companyName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth > 400 ? 13 : 11,
                        )),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: screenWidth > 400 ? 18 : 15,
                          ),
                          Text(
                              widget.advertiserInfo?.advertiserAvgStar
                                      .toString() ??
                                  widget.advertiserAvgStar.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth > 400 ? 13 : 11,
                              )),
                        ],
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
