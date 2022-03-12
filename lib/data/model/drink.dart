class Drink {
  late List<String> name;

  Drink({required this.name});

  Drink.fromJson(Map<String, dynamic> json) {
    Drink(name: json['name']);
  }
}
