import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ColorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GenerateRandomColor extends ColorEvent {}

class SelectColor extends ColorEvent {
  final Color color;
  @override
  List<Object> get props => [color];

  SelectColor(this.color);
}

class LoadColors extends ColorEvent {}
