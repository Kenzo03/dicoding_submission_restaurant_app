import 'dart:convert';
import './food.dart';
import './drink.dart';

class Menu {
  late Food foods;
  late Drink drinks;

  Menu({required this.foods, required this.drinks});

  Menu.fromJson(Map<String, dynamic> json) {
    Menu(
        foods: Food.fromJson(json['foods']),
        drinks: Drink.fromJson(json['drinks']));
  }
}
