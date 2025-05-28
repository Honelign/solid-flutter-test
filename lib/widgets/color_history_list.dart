import 'package:flutter/material.dart';
import 'package:solid_flutter_test/models/color_model.dart';
import 'package:solid_flutter_test/widgets/color_swatch_item.dart';

class ColorHistoryList extends StatelessWidget {
  final List<ColorModel> colors;
  final void Function(Color) onColorSelected;

  const ColorHistoryList({
    required this.colors,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (_, index) => ColorSwatchItem(
          color: colors[index].color,
          onTap: () => onColorSelected(colors[index].color),
        ),
      ),
    );
  }
}
