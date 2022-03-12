import 'package:flutter/material.dart';
import './data/model/restaurant.dart';
import 'dart:convert';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Restoran')),
        body: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              print('datanya ${snapshot.data}');
              if (snapshot.hasData) {
                print('ada data');
                var jsonMap = jsonDecode(snapshot.data!);
                var restaurant = Restaurant.fromJson(jsonMap);
                return ListView.builder(
                    itemCount: restaurant.restaurants.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(
                          context, restaurant.restaurants[index]);
                    });
              } else {
                print('ga ada data');
                return Column(
                  children: const [Text('No Data')],
                );
              }
            }));
  }

  Widget _buildListItem(BuildContext context, RestaurantItem restaurant) {
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
    ));
  }
}
