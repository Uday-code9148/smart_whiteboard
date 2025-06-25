part of 'whiteboard_main_bloc.dart';

@immutable
class WhiteboardMainState {
  final StateEnum state;
  final List<DrawingPointEntity> drawingPoint;
  final DrawingPointEntity? currentDrawingPoint;
  final bool isZoomMode;
  final bool isModelsDownload;
  final Color selectedColor;
  final double selectedStroke;
  final FeatureCategory? selectedCategory;

  const WhiteboardMainState({
    this.state = StateEnum.initial,
    this.drawingPoint = const [],
    this.currentDrawingPoint,
    this.isZoomMode = false,
    this.selectedColor = Colors.black,
    this.selectedStroke = 4.0,
    this.selectedCategory,
    this.isModelsDownload = false,
  });

  WhiteboardMainState copyWith({
    StateEnum? state,
    List<DrawingPointEntity>? drawingPoint,
    DrawingPointEntity? currentDrawingPoint,
    bool makeCurrentDrawingNull = false,
    bool? isZoomMode,
    bool? isModelsDownload,
    Color? selectedColor,
    double? selectedStroke,
    FeatureCategory? selectedCategory,
  }) {
    return WhiteboardMainState(
      state: state ?? this.state,
      drawingPoint: drawingPoint ?? this.drawingPoint,
      currentDrawingPoint: makeCurrentDrawingNull ? null : currentDrawingPoint ?? this.currentDrawingPoint,
      isZoomMode: isZoomMode ?? this.isZoomMode,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedStroke: selectedStroke ?? this.selectedStroke,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isModelsDownload: isModelsDownload ?? this.isModelsDownload,
    );
  }

  WhiteboardMainState reset() {
    return WhiteboardMainState();
  }
}
