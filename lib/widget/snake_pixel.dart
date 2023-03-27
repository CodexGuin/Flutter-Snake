import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
    );
  }
}
