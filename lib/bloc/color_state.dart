import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solid_flutter_test/models/color_model.dart';

abstract class ColorState extends Equatable {
  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {}

class ColorLoaded extends ColorState {
  final Color currentColor;

  final List<ColorModel> colorHistory;
  @override
  List<Object> get props => [currentColor, colorHistory];

  ColorLoaded({required this.currentColor, required this.colorHistory});
}
class ColorError extends ColorState{
final String message;
ColorError(this.message, );

}
  

