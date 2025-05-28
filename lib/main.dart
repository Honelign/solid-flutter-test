import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_flutter_test/bloc/color_bloc.dart';
import 'package:solid_flutter_test/screens/color_changing_screen.dart';
import 'package:solid_flutter_test/services/color_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final colorStorageService = ColorStorageService();

  runApp(Main(colorStorageService: colorStorageService));
}

class Main extends StatelessWidget {
  final ColorStorageService colorStorageService;

  const Main({required this.colorStorageService, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ColorBloc(colorStorageService),
      child: const MaterialApp(home: ColorChangingScreen()),
    );
  }
}
