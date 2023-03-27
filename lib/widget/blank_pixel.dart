import 'package:flutter/material.dart';

class BlankPixel extends StatelessWidget {
  const BlankPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.grey.shade800,
      ),
    );
  }
}
