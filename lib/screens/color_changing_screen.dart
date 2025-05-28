import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_flutter_test/bloc/color_bloc.dart';
import 'package:solid_flutter_test/bloc/color_event.dart';
import 'package:solid_flutter_test/bloc/color_state.dart';
import 'package:solid_flutter_test/widgets/color_history_list.dart';

class ColorChangingScreen extends StatelessWidget {
  const ColorChangingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        if (state is ColorInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ColorLoaded) {
          return GestureDetector(
            onTap: () => context.read<ColorBloc>().add(GenerateRandomColor()),
            child: Scaffold(
              backgroundColor: state.currentColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Hello there',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ColorHistoryList(
                    colors: state.colorHistory,
                    onColorSelected:
                        (color) =>
                            context.read<ColorBloc>().add(SelectColor(color)),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
