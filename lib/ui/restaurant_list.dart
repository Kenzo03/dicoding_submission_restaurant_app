import 'package:flutter/material.dart';
import 'dart:convert';

//Model
import '../data/model/restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restoran'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: _buildRestaurantList(context));
  }

  Widget _buildRestaurantList(BuildContext context) {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var jsonMap = jsonDecode(snapshot.data!);
            var restaurant = Restaurant.fromJson(jsonMap);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurant List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                        itemCount: restaurant.restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurant.restaurants[index]);
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: const [Text('No Data')],
            );
          }
        });
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantItem restaurant) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    child: Image.network(restaurant.pictureId,
                        height: 120, fit: BoxFit.fill),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ],
              )),
          Expanded(
            flex: 3,
            child: _buildRestaurantInfo(
                context,
                restaurant.name,
                restaurant.city,
                restaurant.category,
                restaurant.rating,
                restaurant.tags),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo(BuildContext context, String name, String city,
      String category, double rating, List<String> tags) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 14),
              const SizedBox(
                width: 8,
              ),
              Text(
                city,
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.category, color: Colors.grey, size: 14),
              const SizedBox(
                width: 8,
              ),
              Text(
                category,
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 14),
              const SizedBox(
                width: 8,
              ),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: tags.map((tag) {
                  return Row(
                    children: [
                      Chip(padding: const EdgeInsets.all(4), label: Text(tag)),
                      const SizedBox(width: 8)
                    ],
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }
}
