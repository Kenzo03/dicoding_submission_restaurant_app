import 'package:flutter/material.dart';
import 'dart:convert';

//Model
import '../data/model/restaurant.dart';

//UI
import './restaurant_detail.dart';

//Widget
import '../widgets/blankslate.dart';
import '../widgets/card_image.dart';

//Controller
import '../controller/restaurant_controller.dart';

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
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              _buildRestaurantCategory(context),
              SizedBox(height: 20),
              const Text(
                'Trending Restaurant',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              _buildTrendingRestaurantList(context)
            ])));
  }

  Widget _buildRestaurantCategory(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantCategoryItem(
                      context, snapshot.data![index]);
                },
              ),
            );
          } else if (snapshot.hasError) {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Padding _buildRestaurantCategoryItem(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.height / 4,
          child: Center(
              child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ))),
    );
  }

  Widget _buildTrendingRestaurantList(BuildContext context) {
    return FutureBuilder<List<RestaurantItem>>(
        future: fetchTrendingRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  RestaurantItem tempData = snapshot.data![index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CardImage(
                        imgUrl: tempData.pictureId,
                        category: tempData.category,
                        city: tempData.city,
                        name: tempData.name,
                        rating: tempData.rating,
                        onTap: () {
                          Navigator.pushNamed(
                              context, RestaurantDetailPage.routeName,
                              arguments: tempData);
                        }),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Blankslate();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildRestaurantList(BuildContext context) {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var jsonMap = jsonDecode(snapshot.data!);
            var restaurant = Restaurant.fromJson(jsonMap);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: restaurant.restaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantItem(
                        context, restaurant.restaurants[index]);
                  }),
            );
          } else if (snapshot.hasError) {
            return const Blankslate();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantItem restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant);
      },
      child: Padding(
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
