import 'package:clout/providers/image_picker_controller.dart';
import 'package:clout/widgets/image_pickder/image_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({super.key, required this.controllerTag});

  final controllerTag;

  @override
  Widget build(BuildContext context) {
    double imgBoxSize = MediaQuery.of(context).size.width * 0.2;
    return GetBuilder<ImagePickerController>(
      tag: controllerTag,
      builder: (controller) => Row(
        children: [
          if (controller.images.length == 4) ...[
            ...controller.images
                .map(
                  (e) => ImageBox(
                    img: e,
                    imgBoxSize: imgBoxSize,
                    controllerTag: controllerTag,
                  ),
                )
                .toList(),
          ] else ...[
            ...controller.images
                .map(
                  (e) => ImageBox(
                    img: e,
                    imgBoxSize: imgBoxSize,
                    controllerTag: controllerTag,
                  ),
                )
                .toList(),
            InkWell(
              onTap: () => controller.getImage(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.grey[400]!),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'image',
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    )
                  ],
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
