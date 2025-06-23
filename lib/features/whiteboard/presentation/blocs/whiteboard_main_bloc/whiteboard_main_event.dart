part of 'whiteboard_main_bloc.dart';

@immutable
sealed class WhiteboardMainEvent {}

class WhiteboardMainInitialEvent extends WhiteboardMainEvent {}

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

class ClearCanvasEvent extends WhiteboardMainEvent {}
