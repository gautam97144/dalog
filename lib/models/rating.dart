import 'package:flutter/cupertino.dart';

class Rating {
  String? title;

  Rating({
    this.title,
  });
}

List<Rating> _rating = [
  Rating(
    title: "Driver behavior",
  ),
  Rating(
    title: "Overall experience",
  ),
  Rating(
    title: "Product Handling and delivery",
  ),
  Rating(
    title: "Pricing",
  )
];
List<Rating> get rating => _rating;

// class RatingIndex {
//   int? initialIndex;
//
//   RatingIndex({this.initialIndex});
// }

// ValueNotifier<List<RatingIndex>> ratingIndex = ValueNotifier([
//   RatingIndex(initialIndex: 0),
//   RatingIndex(initialIndex: 0),
//   RatingIndex(initialIndex: 0),
//   RatingIndex(initialIndex: 0)
// ]);
