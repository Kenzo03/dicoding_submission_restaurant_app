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
        // appBar: AppBar(title: Text(restaurant.name)),
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(restaurant.pictureId,
                          fit: BoxFit.fitWidth),
                      title: Text(restaurant.name),
                      titlePadding:
                          const EdgeInsets.only(left: 48, bottom: 16)),
                )
              ];
            },
            body: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(restaurant.description)],
                    ))
              ],
            ))
        // SingleChildScrollView(
        //     child: Column(
        //   children: [
        //     Text(restaurant.description),
        //     const SizedBox(
        //       height: 8,
        //     ),
        //     Text(restaurant.city)
        //   ],
        // ))
        );
  }
}
