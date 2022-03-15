import 'package:flutter/material.dart';

//Model
import '../data/model/restaurant.dart';

//UI
import './restaurant_detail.dart';

//Widget
import '../widgets/blankslate.dart';

//Controller
import '../controller/restaurant_controller.dart';

class RecommendedList extends StatelessWidget {
  static const routeName = '/recommended_list';

  const RecommendedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Today' 's Recommended Restaurant'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildRestaurantList(context),
        ));
  }

  Widget _buildRestaurantList(BuildContext context) {
    return FutureBuilder<List<RestaurantItem>>(
        future: fetchRecommendedRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantItem(context, snapshot.data![index]);
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
                    Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        child: Image.network(restaurant.pictureId,
                            height: 120, fit: BoxFit.fill),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
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
