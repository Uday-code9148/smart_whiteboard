part of 'whiteboard_main_bloc.dart';

@immutable
sealed class WhiteboardMainEvent {}

class WhiteboardMainInitialEvent extends WhiteboardMainEvent {
  final BuildContext context;

  WhiteboardMainInitialEvent(this.context);
}

class SelectCategoryEvent extends WhiteboardMainEvent {
  final FeatureCategory selectedCategory;

  SelectCategoryEvent({required this.selectedCategory});
}

class PanStartEvent extends WhiteboardMainEvent {
  final Offset? points;

  PanStartEvent({this.points});
}

class PanUpdateEvent extends WhiteboardMainEvent {
  final Offset? points;

  PanUpdateEvent({this.points});
}

class PanEndEvent extends WhiteboardMainEvent {}

class ToggleZoomMode extends WhiteboardMainEvent {}

class SelectColorEvent extends WhiteboardMainEvent {
  final Color selectedColor;

  SelectColorEvent({required this.selectedColor});
}

class SelectStrokeEvent extends WhiteboardMainEvent {
  final double selectedStroke;

  SelectStrokeEvent({required this.selectedStroke});
}

class ClearCanvasEvent extends WhiteboardMainEvent {}

class EnsureRecognitionModelsDownloadEvent extends WhiteboardMainEvent {}
class TextRecognitionEvent extends WhiteboardMainEvent {}

class MathRecognitionEvent extends WhiteboardMainEvent {}
