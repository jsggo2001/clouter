import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class StarRating extends StatefulWidget {
  final int maxRating; // 최대 점수 (별 개수)
  final int initialRating; // 초기 점수
  final Function(int) onRatingChanged; // 사용자가 점수를 변경했을 때 호출할 함수

  StarRating({
    required this.maxRating,
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxRating, (index) {
        final isFilled = index < rating;
        return GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1;
              widget.onRatingChanged(rating);
            });
          },
          child: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: isFilled ? Colors.amber : style.colors['main1'],
            size: 50,
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Star Rating Example'),
      ),
      body: Center(
        child: StarRating(
          maxRating: 5,
          initialRating: 3,
          onRatingChanged: (rating) {
            print('별점: $rating');
          },
        ),
      ),
    ),
  ));
}
