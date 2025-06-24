import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:inboard_personal_project/core/services/di_services/service_locator.dart' show getIt;
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';

void showColorPicker(BuildContext context, Color selectedColor) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text("Choose Color"),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              Navigator.of(ctx).pop();
              getIt<WhiteboardMainBloc>().add(SelectColorEvent(selectedColor: color));
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Done"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      );
    },
  );
}

void showStrokeWidthPicker(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Choose Stroke Width"),
      content: BlocBuilder<WhiteboardMainBloc, WhiteboardMainState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                min: 1,
                max: 20,
                value: state.selectedStroke,
                onChanged: (value) {
                  getIt<WhiteboardMainBloc>().add(SelectStrokeEvent(selectedStroke: value));
                },
              ),
              Text("Width: ${state.selectedStroke.toInt()}"),
            ],
          );
        },
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text("Apply"),
        ),
      ],
    ),
  );
}
