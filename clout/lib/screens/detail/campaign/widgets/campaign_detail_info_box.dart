import 'package:clout/type.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:intl/intl.dart';

// widgets
import 'package:clout/utilities/category_translator.dart';
import 'package:clout/widgets/common/nametag.dart';

class CampaignDetailInfoBox extends StatefulWidget {
  final CampaignInfo campaignInfo;
  final AdvertiserInfo advertiserInfo;

  CampaignDetailInfoBox(
      {super.key, required this.campaignInfo, required this.advertiserInfo});

  @override
  State<CampaignDetailInfoBox> createState() => _CampaignDetailInfoBoxState();
}

class _CampaignDetailInfoBoxState extends State<CampaignDetailInfoBox> {
  @override
  void initState() {
    loadPlatform();
    super.initState();
  }

  Widget platforms = Container();

  var f = NumberFormat('###,###,###,###');

  loadPlatform() {
    List<Widget> snsIcons = [];
    if (widget.campaignInfo.adPlatformList!.contains('INSTAGRAM')) {
      snsIcons.add(SizedBox(width: 5));
      snsIcons.add(Image.asset(
        'assets/images/INSTAGRAM.png',
        width: 20,
        fit: BoxFit.cover,
      ));
    }
    if (widget.campaignInfo.adPlatformList!.contains('TIKTOK')) {
      snsIcons.add(SizedBox(width: 5));
      snsIcons.add(Image.asset(
        'assets/images/TIKTOK.png',
        width: 20,
        fit: BoxFit.cover,
      ));
    }
    if (widget.campaignInfo.adPlatformList!.contains('YOUTUBE')) {
      snsIcons.add(SizedBox(width: 5));
      snsIcons.add(Image.asset(
        'assets/images/YOUTUBE.png',
        width: 20,
        fit: BoxFit.cover,
      ));
    }
    setState(() {
      platforms = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: snsIcons,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: style.colors['gray']!),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NameTag(
              title: AdCategoryTranslator.translateAdCategory(
                  widget.campaignInfo.adCategory!)),
          SizedBox(height: 10),
          Text(
            widget.campaignInfo.title!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.corporate_fare_outlined),
              SizedBox(width: 10),
              Text('협찬 제공사', style: TextStyle(fontSize: 15)),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.advertiserInfo.companyInfo!.companyName!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 2),
                      Text(widget.advertiserInfo.advertiserAvgStar.toString(),
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.receipt_long_outlined),
              SizedBox(width: 10),
              Text('희망 플랫폼', style: TextStyle(fontSize: 15)),
              Expanded(
                child: platforms,
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.event_outlined),
              SizedBox(width: 10),
              Text('신청 기간', style: TextStyle(fontSize: 15)),
              Expanded(
                  child: Text(
                '${widget.campaignInfo.applyStartDate} ~ ${widget.campaignInfo.applyEndDate}',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ))
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.monetization_on_outlined,
                  color: style.colors['main1']),
              SizedBox(width: 10),
              Text('지급 포인트', style: TextStyle(fontSize: 15, height: 1.2)),
              widget.campaignInfo.price != 0
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            f.format(widget.campaignInfo.price),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' 포인트',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '없음',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    )
            ],
          ),
          SizedBox(height: 8),
          Row(children: [
            Icon(Icons.groups_outlined),
            SizedBox(width: 10),
            Text('신청자 수 / 모집 인원', style: TextStyle(fontSize: 15)),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.campaignInfo.numberOfApplicants.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                Text('명 / ',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                Text(widget.campaignInfo.numberOfRecruiter.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                Text('명',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            )),
          ]),
          SizedBox(
            height: 7,
          )
        ]),
      ),
    );
  }
}
