import 'package:clout/widgets/input/input_elements/input_element.dart';
import 'package:flutter/material.dart';

class FollowersDropdown extends StatelessWidget {
  FollowersDropdown({super.key, this.setFollower, this.follower});
  final setFollower;
  final follower;

  final followers = [
    '~1만명',
    '1~3만명',
    '3~5만명',
    '5~7만명',
    '7~10만명',
    '10~20만명',
    '20~30만명',
    '30만명~',
  ];

  @override
  Widget build(BuildContext context) {
    return InputElement(
      elementType: 'dropdown',
      setData: setFollower,
      data: followers,
      value: follower,
      placeholder: '팔로워 수 or 구독자 수',
    );
  }
}
