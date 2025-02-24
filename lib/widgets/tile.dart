import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({super.key, required this.asset, required this.onAuthenticate});

  final String asset;
  final Function() onAuthenticate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAuthenticate,
      child: Container(
        
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          asset,
        ),
      ),
    );
  }
}
