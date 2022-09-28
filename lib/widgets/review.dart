import 'package:dicoding_restaurants/data/model/detail_restaurant_model.dart';
import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final CustomerReview review;
  const Review({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://ui-avatars.com/api/?name=default+name'),
              ),
              Text(review.name),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(flex: 4, child: Text(review.review)),
        Expanded(
            flex: 2,
            child: Text(
              review.date,
              style: const TextStyle(fontSize: 12),
            )),
      ],
    );
  }
}
