import 'package:deresto/ui/home_page.dart';
import 'package:flutter/material.dart';

//Model
import './data/model/restaurant.dart';

//UI
import './ui/restaurant_list.dart';
import './ui/restaurant_detail.dart';
import './ui/home_page.dart';
import './ui/favorite_list.dart';
import './ui/recommended_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeResto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        FavoriteList.routeName: (context) => const FavoriteList(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as RestaurantItem,
            )
      },
    );
  }
}
