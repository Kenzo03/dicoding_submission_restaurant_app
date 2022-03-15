import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
            SnackBar snackBar = SnackBar(
                content: Text(isFavorite
                    ? 'Added to Favorite'
                    : 'Removed from Favorite'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        });
  }
}
