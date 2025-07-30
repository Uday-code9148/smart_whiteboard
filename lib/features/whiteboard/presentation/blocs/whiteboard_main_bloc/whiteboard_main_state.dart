part of 'whiteboard_main_bloc.dart';

@immutable
class WhiteboardMainState {
  final StateEnum state;
  final List<DrawingPointEntity> drawingPoint;
  final DrawingPointEntity? currentDrawingPoint;
  final CategoryEnum selectedCategoryEnum;
  final bool isModelsDownload;
  final Color selectedColor;
  final double selectedStroke;
  final ShapesEnum? selectedShape;
  final FeatureCategory? selectedCategory;

  const WhiteboardMainState({
    this.state = StateEnum.initial,
    this.drawingPoint = const [],
    this.currentDrawingPoint,
    this.selectedCategoryEnum = CategoryEnum.pen,
    this.selectedColor = Colors.black,
    this.selectedStroke = 4.0,
    this.selectedCategory,
    this.isModelsDownload = false,
    this.selectedShape,
  });

  WhiteboardMainState copyWith({
    StateEnum? state,
    List<DrawingPointEntity>? drawingPoint,
    DrawingPointEntity? currentDrawingPoint,
    bool makeCurrentDrawingNull = false,
    CategoryEnum? selectedCategoryEnum,
    bool? isModelsDownload,
    Color? selectedColor,
    double? selectedStroke,
    FeatureCategory? selectedCategory,
    ShapesEnum? selectedShape,
  }) {
    return WhiteboardMainState(
      state: state ?? this.state,
      drawingPoint: drawingPoint ?? this.drawingPoint,
      currentDrawingPoint: makeCurrentDrawingNull ? null : currentDrawingPoint ?? this.currentDrawingPoint,
      selectedCategoryEnum: selectedCategoryEnum ?? this.selectedCategoryEnum,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedStroke: selectedStroke ?? this.selectedStroke,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isModelsDownload: isModelsDownload ?? this.isModelsDownload,
      selectedShape: selectedShape ?? this.selectedShape,
    );
  }

  WhiteboardMainState reset() {
    return WhiteboardMainState();
  }
}
