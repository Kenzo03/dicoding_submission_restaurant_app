import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantItem restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(restaurant.name)),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Text(restaurant.description),
            const SizedBox(
              height: 8,
            ),
            Text(restaurant.city)
          ],
        )));
  }
}
