//widgets
//pages
import 'package:clout/screens/register_or_modify/advertiser/advertiser_join.dart';
import 'package:clout/screens/register_or_modify/clouter/clouter_join.dart';
import 'package:clout/widgets/buttons/big_button.dart';

//global
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class Join extends StatelessWidget {
  const Join({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () => Get.to(ClouterJoin()),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/clouter.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(color: Colors.black.withOpacity(0.1)),
                  ),
                  Positioned(
                    top: screenHeight / 2 - 200,
                    left: screenWidth / 2 - 100,
                    child: Row(
                      children: [
                        Text(
                          '클라우터',
                          style: style.textTheme.titleLarge?.copyWith(
                              color: style.colors['main1'],
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '로',
                          style: style.textTheme.titleLarge?.copyWith(
                              color: style.colors['white'],
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight / 2 - 150,
                    left: screenWidth / 2 - 20,
                    child: Text(
                      '시작하기',
                      style: style.textTheme.titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 30,
          //   // color: style.colors['main1'],
          //   child:Text('당신은')
          // ),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () => Get.to(AdvertiserJoin()),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/advertiser.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(color: Colors.black.withOpacity(0.1)),
                  ),
                  Positioned(
                    top: screenHeight / 2 - 200,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '광고주로 시작하기',
                          style: style.textTheme.titleLarge?.copyWith(
                              color: style.colors['main1-4'],
                              fontWeight: FontWeight.w500),
                        ),
                        // Text(
                        //   '로',
                        //   style: style.textTheme.titleLarge?.copyWith(
                        //       color: style.colors['white'],
                        //       fontWeight: FontWeight.w500),
                        // ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: screenHeight / 2 - 150,
                  //   left: 0,
                  //   right: 0,
                  //   child: Text(
                  //     '시작하기',
                  //     style: style.textTheme.titleLarge?.copyWith(
                  //       color: Colors.white,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
