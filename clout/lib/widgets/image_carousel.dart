import 'package:carousel_slider/carousel_slider.dart';
import 'package:clout/screens/detail/campaign/campaign_detail.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  ImageCarousel({
    super.key,
    required this.imageSliders,
    required this.aspectRatio,
    required this.enlarge,
    this.infiniteScroll,
  });
  final List<Widget> imageSliders;
  final double aspectRatio;
  final bool enlarge;
  final bool? infiniteScroll;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        CarouselSlider(
          items: widget.imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              enableInfiniteScroll: widget.infiniteScroll ?? true,
              autoPlay: true,
              enlargeCenterPage: widget.enlarge,
              aspectRatio:
                  widget.aspectRatio != 0 ? widget.aspectRatio : 16 / 8,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageSliders.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Colors.black)
                            .withOpacity(_current == entry.key ? 0.4 : 0.2)),
                  ),
                );
              }).toList(),
            )),
      ]),
    ]);
  }
}
