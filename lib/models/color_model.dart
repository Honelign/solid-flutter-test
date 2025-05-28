import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorModel extends Equatable {
  final Color color;
  @override
  List<Object> get props => [color.toARGB32()];

  const ColorModel({required this.color});

  factory ColorModel.fromInt(int value) => ColorModel(color: Color(value));

  int toInt() => color.toARGB32();
}
