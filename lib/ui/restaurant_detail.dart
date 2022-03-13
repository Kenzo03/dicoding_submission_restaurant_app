import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantItem restaurantData;

  const RestaurantDetailPage({Key? key, required this.restaurantData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(restaurantData.name)),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Text(restaurantData.description),
            const SizedBox(
              height: 8,
            ),
            Text(restaurantData.city)
          ],
        )));
  }
}
