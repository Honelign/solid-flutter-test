// ignore_for_file: avoid_debug_print_in_release
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_flutter_test/models/color_model.dart';


class ColorStorageService {
  static const String _colorHistoryKey = 'color_history';

  Future<void> saveColorHistory(List<ColorModel?> colors) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final colorValues = colors.map((c) => c?.toInt()).toList();
      await prefs.setStringList(
        _colorHistoryKey,
        colorValues.map((c) => c.toString()).toList(),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Retrieves the color history from SharedPreferences.
  Future<List<ColorModel>> getColorHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final colorStrings = prefs.getStringList(_colorHistoryKey) ?? [];
      
      return colorStrings
          .map((str) => ColorModel.fromInt(int.parse(str)))
          .toList();
    } catch (e) {
      // Return empty list on error
      return [];
    }
  }
}
