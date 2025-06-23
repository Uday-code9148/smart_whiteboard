import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/common/enums/state_enum.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';

part 'whiteboard_main_event.dart';

part 'whiteboard_main_state.dart';

class WhiteboardMainBloc extends Bloc<WhiteboardMainEvent, WhiteboardMainState> {
  final TransformationController controller = TransformationController();

  WhiteboardMainBloc() : super(const WhiteboardMainState()) {
    on<WhiteboardMainInitialEvent>(_onInitial);
    on<PanStartEvent>(_onPanStart);
    on<PanUpdateEvent>(_onPanUpdate);
    on<PanEndEvent>(_onPanEnd);
    on<ToggleZoomMode>(_onToggleZoomMode);
    on<ClearCanvasEvent>(_onClearCanvas);
  }

  FutureOr<void> _onInitial(WhiteboardMainInitialEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state);
  }

  FutureOr<void> _onPanStart(PanStartEvent event, Emitter<WhiteboardMainState> emit) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final newPoint = DrawingPointEntity(points: event.points, paint: paint);
    final updatedList = List<DrawingPointEntity>.from(state.drawingPoint)..add(newPoint);

    emit(state.copyWith(drawingPoint: updatedList, currentDrawingPoint: newPoint));
  }

  FutureOr<void> _onPanUpdate(PanUpdateEvent event, Emitter<WhiteboardMainState> emit) {
    if (state.currentDrawingPoint != null) {
      final updatedPoint = state.currentDrawingPoint!.copyWith(points: event.points);
      final updatedList = List<DrawingPointEntity>.from(state.drawingPoint)..add(updatedPoint);

      emit(state.copyWith(drawingPoint: updatedList, currentDrawingPoint: updatedPoint));
    }
  }

  FutureOr<void> _onPanEnd(PanEndEvent event, Emitter<WhiteboardMainState> emit) {
    final updatedPoints = List<DrawingPointEntity>.from(state.drawingPoint)..add(DrawingPointEntity(points: null, paint: null)); // ← break stroke

    emit(state.copyWith(drawingPoint: updatedPoints, makeCurrentDrawingNull: true));
  }

  FutureOr<void> _onToggleZoomMode(ToggleZoomMode event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(isZoomMode: !state.isZoomMode));
  }

  FutureOr<void> _onClearCanvas(ClearCanvasEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(drawingPoint: [], makeCurrentDrawingNull: true));
  }
}
