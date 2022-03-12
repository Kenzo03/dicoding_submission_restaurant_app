import 'package:flutter/material.dart';
import 'dart:convert';

//Model
import '../data/model/restaurant.dart';

//UI
import './restaurant_detail.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Restoran'),
          shape: RoundedRectangleBorder(
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
            return ListView.builder(
                itemCount: restaurant.restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem2(
                      context, restaurant.restaurants[index]);
                });
          } else {
            return Column(
              children: const [Text('No Data')],
            );
          }
        });
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantItem restaurant) {
    return Material(
        child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
    ));
  }

  Widget _buildRestaurantItem2(
      BuildContext context, RestaurantItem restaurant) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: ClipRRect(
                child: Image.network(restaurant.pictureId, fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              )),
          Expanded(
            flex: 3,
            child: _buildRestaurantInfo(
              context,
              restaurant.name,
              restaurant.city,
              restaurant.rating,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfo(
      BuildContext context, String name, String city, double rating) {
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
              Icon(Icons.location_on, color: Colors.grey, size: 14),
              SizedBox(
                width: 8,
              ),
              Text(
                city,
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 14),
              SizedBox(
                width: 8,
              ),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
