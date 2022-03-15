import 'package:flutter/material.dart';

//Model
import '../data/model/restaurant.dart';

//UI
import './restaurant_detail.dart';

//Widget
import '../widgets/blankslate.dart';
import '../widgets/card_image.dart';
import '../widgets/card_label.dart';

//Controller
import '../controller/restaurant_controller.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Deresto'),
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
                'Trending Restaurant',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              _buildTrendingRestaurantList(context),
              const SizedBox(height: 20),
              const Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              _buildRestaurantCategoryList(context),
              const SizedBox(height: 20),
              const Text(
                'City',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              _buildRestaurantCityList(context),
            ])));
  }

  Widget _buildRestaurantCategoryList(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardLabel(label: snapshot.data![index]);
                },
              ),
            );
          } else if (snapshot.hasError) {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildRestaurantCityList(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fetchCities(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CardLabel(label: snapshot.data![index]);
                },
              ),
            );
          } else if (snapshot.hasError) {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildTrendingRestaurantList(BuildContext context) {
    return FutureBuilder<List<RestaurantItem>>(
        future: fetchTrendingRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
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
                        tags: tempData.tags,
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
}
