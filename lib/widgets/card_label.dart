import 'package:flutter/material.dart';

class CardLabel extends StatelessWidget {
  final String label;

  const CardLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(8)),
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.height / 4,
          child: Center(
              child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ))),
    );
  }
}
