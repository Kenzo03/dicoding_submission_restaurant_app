import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String city;
  final String category;
  final double rating;
  final List<String> tags;
  final Function() onTap;

  const CardImage(
      {Key? key,
      required this.category,
      required this.city,
      required this.imgUrl,
      required this.name,
      required this.rating,
      required this.tags,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.9,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4.2,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Hero(
                          tag: imgUrl,
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.orange.shade400,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$rating",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7.0),
                //Restaurant Name
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                //Restaurant city and category
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.black54),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              city,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            const Icon(Icons.category,
                                size: 14, color: Colors.black54),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              category,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                //Restaurant tags
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: tags.map((tag) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
