import 'package:flutter/material.dart';


class ColorSwatchItem extends StatelessWidget {
  final Color color;
  
  final VoidCallback onTap;

  const ColorSwatchItem({
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
