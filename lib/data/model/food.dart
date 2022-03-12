class Food {
  late List<String> name;

  Food({required this.name});

  Food.fromJson(Map<String, dynamic> json) {
    Food(name: json['name']);
  }
}
