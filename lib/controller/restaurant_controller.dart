import 'dart:convert';
import 'package:flutter/services.dart';

//Model
import '../data/model/restaurant.dart';

Future<List<String>> fetchCategories() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    List<String> distinct =
        List<String>.from(restaurant.restaurants.map((x) => x.category));
    return [
      ...{...distinct}
    ];
  }
}

Future<List<String>> fetchCities() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    List<String> distinct =
        List<String>.from(restaurant.restaurants.map((x) => x.city));
    return [
      ...{...distinct}
    ];
  }
}

Future<List<RestaurantItem>> fetchTrendingRestaurant() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    return List<RestaurantItem>.from(
        restaurant.restaurants.where((x) => x.isTrending));
  }
}

Future<List<RestaurantItem>> fetchRecommendedRestaurant() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    return List<RestaurantItem>.from(
        restaurant.restaurants.where((x) => x.isRecommended));
  }
}

Future<List<RestaurantItem>> fetchFavoritedRestaurant() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    return List<RestaurantItem>.from(
        restaurant.restaurants.where((x) => x.isFavorited));
  }
}

Future<List<RestaurantItem>> fetchRestaurants() async {
  var jsonText = await rootBundle.loadString('assets/local_restaurant.json');
  var jsonMap = jsonDecode(jsonText);
  var restaurant = Restaurant.fromJson(jsonMap);

  if (jsonText == '') {
    return [];
  } else {
    return List<RestaurantItem>.from(restaurant.restaurants);
  }
}
