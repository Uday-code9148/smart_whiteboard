part of 'whiteboard_main_bloc.dart';

@immutable
class WhiteboardMainState {
  final StateEnum state;
  final List<DrawingPointEntity> drawingPoint;
  final DrawingPointEntity? currentDrawingPoint;
  final bool isZoomMode;

  const WhiteboardMainState({this.state = StateEnum.initial, this.drawingPoint = const [], this.currentDrawingPoint, this.isZoomMode = false});

  WhiteboardMainState copyWith({
    StateEnum? state,
    List<DrawingPointEntity>? drawingPoint,
    DrawingPointEntity? currentDrawingPoint,
    bool makeCurrentDrawingNull = false,
    bool? isZoomMode,
  }) {
    return WhiteboardMainState(
      state: state ?? this.state,
      drawingPoint: drawingPoint ?? this.drawingPoint,
      currentDrawingPoint: makeCurrentDrawingNull ? null : currentDrawingPoint ?? this.currentDrawingPoint,
      isZoomMode: isZoomMode ?? this.isZoomMode,
    );
  }

  WhiteboardMainState reset() {
    return WhiteboardMainState();
  }
}
