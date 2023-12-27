import 'dart:io';

import 'package:clout/providers/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class ImageBox extends StatelessWidget {
  ImageBox({super.key, this.img, this.imgBoxSize, required this.controllerTag});
  final img;
  final imgBoxSize;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagePickerController>(
      tag: controllerTag,
      builder: (controller) => GestureDetector(
        onTap: () => controller.delImage(img),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: imgBoxSize,
          height: imgBoxSize,
          child: Stack(
            children: [
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: style.colors['main1']!),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.file(File(img.path)).image),
                          borderRadius: BorderRadius.circular(10)),
                      width: imgBoxSize,
                      height: imgBoxSize)),
              // 사진 삭제하는 버튼(오른쪽 위 X버튼)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.grey[400],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
