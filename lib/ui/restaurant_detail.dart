import 'package:flutter/material.dart';
import '../data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final RestaurantItem restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(restaurant.name)),
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(restaurant.pictureId,
                            fit: BoxFit.fitWidth),
                      ),
                      title: Text(restaurant.name),
                      titlePadding:
                          const EdgeInsets.only(left: 48, bottom: 16)),
                )
              ];
            },
            body: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //City and Category
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 18, color: Colors.black54),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Row(
                                children: [
                                  const Icon(Icons.category,
                                      size: 18, color: Colors.black54),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    restaurant.category,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        //Description
                        Text(restaurant.description),
                        const SizedBox(height: 8),
                        //Tags
                        SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: restaurant.tags.map((tag) {
                                return Row(
                                  children: [
                                    Chip(
                                        padding: const EdgeInsets.all(4),
                                        label: Text(tag)),
                                    const SizedBox(width: 8)
                                  ],
                                );
                              }).toList(),
                            )),
                        const SizedBox(height: 16),
                        const Text(
                          'Food List',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuList(
                            context, restaurant.menus.foods, "images/food.jpg"),
                        const SizedBox(height: 16),
                        const Text(
                          'Drink List',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuList(context, restaurant.menus.drinks,
                            "images/drink.jpg"),
                      ],
                    ))
              ],
            )));
  }

  Widget _buildMenuList(
      BuildContext context, List<MenuItem> items, String imgPath) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8), bottom: Radius.zero),
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  items[index].name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        // ListTile(
        //     contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        //     leading: ClipRRect(
        //         borderRadius: BorderRadius.circular(8),
        //         child: Image.asset(imgPath)),
        //     title: Text(items[index].name));
      },
    );
  }
}
