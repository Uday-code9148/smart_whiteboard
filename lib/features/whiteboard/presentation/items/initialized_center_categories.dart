import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/services/di_services/service_locator.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/enums/shapes_enum.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/widgets/show_color_picker_dialogue.dart'
    show showColorPicker, showStrokeWidthPicker;

final centerFeature = FeatureCategory(
  name: 'Center',
  icon: Icon(Icons.text_fields_sharp),
  items: [
    FeatureCategory(name: 'cutter', icon: Icon(Icons.arrow_circle_left), onTap: () {}),
    FeatureCategory(
      name: 'zoom',
      icon: Icon(Icons.zoom_in_map, color: Colors.blue),
      onTap: () {
        getIt<WhiteboardMainBloc>().add(ToggleZoomMode());
      },
    ),
    FeatureCategory(
      name: 'style',
      icon: Icon(Icons.text_fields_sharp),
      onTap: () {},
      items: [
        FeatureCategory(
          name: 'stroke',
          icon: Icon(Icons.self_improvement_rounded),
          onTap: () {
            final context = getIt<WhiteboardMainBloc>().context;
            if (context != null) showStrokeWidthPicker(context);
          },
        ),
        FeatureCategory(
          name: 'text rec',
          icon: Icon(Icons.text_decrease_outlined, color: Colors.greenAccent),
          onTap: () {
            getIt<WhiteboardMainBloc>().add(ToggleZoomMode());
          },
        ),
        FeatureCategory(name: 'math rec', icon: Icon(Icons.calculate_rounded), onTap: () {}),
        FeatureCategory(name: 'shapes rec', icon: Icon(Icons.format_shapes), items: getShapesDetails(), onTap: () {}),
        FeatureCategory(name: 'free hand', icon: Icon(Icons.free_breakfast), onTap: () {}),
        FeatureCategory(
          name: 'color selection',
          icon: Icon(Icons.color_lens),
          onTap: () {
            final context = getIt<WhiteboardMainBloc>().context;
            if (context != null) showColorPicker(context, Colors.black12);
          },
        ),
      ],
    ),
    FeatureCategory(
      name: 'eraser',
      icon: Icon(Icons.phonelink_erase, color: Colors.yellow),
      items: [
        FeatureCategory(
          name: 'delete',
          icon: Icon(Icons.remove_circle_outline_outlined, color: Colors.red),
          onTap: () {
            getIt<WhiteboardMainBloc>().add(ClearCanvasEvent());
          },
        ),
        FeatureCategory(
          name: 'erase',
          icon: Icon(Icons.photo_size_select_small, color: Colors.yellow),
          onTap: () {},
        ),
        FeatureCategory(name: 'free hand', icon: Icon(Icons.free_breakfast), onTap: () {}),
      ],
      onTap: () {},
    ),
    FeatureCategory(name: 'custom', icon: Icon(Icons.arrow_circle_left), onTap: () {}),
  ],
);

List<FeatureCategory> getShapesDetails() {
  return ShapesEnum.values.map((e) {
    return FeatureCategory(name: e.name, icon: e.icon, onTap: () {});
  }).toList();
}
