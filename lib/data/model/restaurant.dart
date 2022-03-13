// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  Restaurant({
    required this.restaurants,
  });

  List<RestaurantItem> restaurants;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurants: List<RestaurantItem>.from(
            json["restaurants"].map((x) => RestaurantItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantItem {
  RestaurantItem({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.category,
    required this.isTrending,
    required this.tags,
    required this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  String category;
  bool isTrending;
  List<String> tags;
  Menus menus;

  factory RestaurantItem.fromJson(Map<String, dynamic> json) => RestaurantItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        category: json["category"],
        isTrending: json["isTrending"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        menus: Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "category": category,
        "isTrending": isTrending,
        "tags": tags.toList(),
        "menus": menus.toJson(),
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<MenuItem> foods;
  List<MenuItem> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<MenuItem>.from(json["foods"].map((x) => MenuItem.fromJson(x))),
        drinks: List<MenuItem>.from(
            json["drinks"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class MenuItem {
  MenuItem({
    required this.name,
  });

  String name;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
