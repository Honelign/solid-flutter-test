import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_flutter_test/bloc/color_event.dart';
import 'package:solid_flutter_test/bloc/color_state.dart';
import 'package:solid_flutter_test/models/color_model.dart';
import 'package:solid_flutter_test/services/color_storage_service.dart'
    show ColorStorageService;

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final ColorStorageService _storageService;
  static const int _maxHistorySize = 5;
  static const int _maxColorValue = 255;
  List<ColorModel>? colorHistory;

  ColorBloc(this._storageService) : super(ColorInitial()) {
    on<LoadColors>(_onLoadColors);
    on<GenerateRandomColor>(_onGenerateRandomColor);
    on<SelectColor>(_onSelectColor);

    add(LoadColors());
  }

  Future<void> _onLoadColors(LoadColors event, Emitter<ColorState> emit) async {
    try {
      colorHistory = await _storageService.getColorHistory();

      final currentColor = colorHistory?.first.color ?? Colors.white;

      emit(
        ColorLoaded(
          currentColor: currentColor,
          colorHistory: colorHistory ?? [const ColorModel(color: Colors.white)],
        ),
      );
    } catch (e) {
      emit(
        ColorLoaded(
          currentColor: Colors.white,
          colorHistory: const [ColorModel(color: Colors.white)],
        ),
      );
    }
  }

  Future<void> _onGenerateRandomColor(
    GenerateRandomColor event,
    Emitter<ColorState> emit,
  ) async {
    try {
      final random = Random();

      final newColor = Color.fromRGBO(
        random.nextInt(_maxColorValue),
        random.nextInt(_maxColorValue),
        random.nextInt(_maxColorValue),
        1,
      );

      final newColorModel = ColorModel(color: newColor);
      final updatedHistory = [newColorModel, colorHistory];

      if (updatedHistory.length > _maxHistorySize) {
        updatedHistory.removeLast();
      }

      await _storageService.saveColorHistory(
        updatedHistory as List<ColorModel>,
      );

      emit(ColorLoaded(currentColor: newColor, colorHistory: updatedHistory));
    } catch (e) {
      ColorLoaded(
        currentColor: Colors.white,
        colorHistory: const [ColorModel(color: Colors.white)],
      );
    }
  }

  Future<void> _onSelectColor(
    SelectColor event,
    Emitter<ColorState> emit,
  ) async {
    try {
      final currentState = state as ColorLoaded;
      final selectedColorModel = ColorModel(color: event.color);

      final existingIndex = currentState.colorHistory.indexWhere(
        (model) => model.color == (event.color),
      );

      List<ColorModel> updatedHistory;
      if (existingIndex >= 0) {
        updatedHistory = List.from(currentState.colorHistory);
        updatedHistory.removeAt(existingIndex);
        updatedHistory.insert(0, selectedColorModel);
      } else {
        updatedHistory = [selectedColorModel, ...currentState.colorHistory];
        if (updatedHistory.length > _maxHistorySize) {
          updatedHistory.removeLast();
        }
      }

      await _storageService.saveColorHistory(updatedHistory);

      emit(
        ColorLoaded(currentColor: event.color, colorHistory: updatedHistory),
      );
    } catch (e) {
      emit(ColorInitial());
    }
  }
}
