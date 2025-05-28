import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_flutter_test/bloc/color_bloc.dart';
import 'package:solid_flutter_test/screens/color_changing_screen.dart';
import 'package:solid_flutter_test/services/color_storage_service.dart';

/// Entry point of the application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final colorStorageService = ColorStorageService();

  runApp(MyApp(colorStorageService: colorStorageService));
}

class MyApp extends StatelessWidget {
  final ColorStorageService colorStorageService;

  const MyApp({required this.colorStorageService, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ColorBloc(colorStorageService),
      child: const MaterialApp(home: ColorChangingScreen()),
    );
  }
}
