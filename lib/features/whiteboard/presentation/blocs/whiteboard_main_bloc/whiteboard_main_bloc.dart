import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/common/enums/state_enum.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/math_rec_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/text_rec_usecase.dart';

part 'whiteboard_main_event.dart';

part 'whiteboard_main_state.dart';

class WhiteboardMainBloc extends Bloc<WhiteboardMainEvent, WhiteboardMainState> {
  final TransformationController controller = TransformationController();
  late final BuildContext? context;
  final TextRecognitionUseCase textRecognitionUseCase;
  final MathRecognitionUseCase mathRecognitionUseCase;

  WhiteboardMainBloc(this.textRecognitionUseCase, this.mathRecognitionUseCase) : super(const WhiteboardMainState()) {
    on<WhiteboardMainInitialEvent>(_onInitial);
    on<SelectCategoryEvent>(_onSelectCategoryEvent);
    on<PanStartEvent>(_onPanStart);
    on<PanUpdateEvent>(_onPanUpdate);
    on<PanEndEvent>(_onPanEnd);
    on<ToggleZoomMode>(_onToggleZoomMode);
    on<SelectColorEvent>(_onSelectColorEvent);
    on<SelectStrokeEvent>(_onSelectStrokeEvent);
    on<ClearCanvasEvent>(_onClearCanvas);
    on<MathRecognitionEvent>(_onMathRecognitionEvent);
    on<TextRecognitionEvent>(_onTextRecognitionEvent);
  }

  FutureOr<void> _onInitial(WhiteboardMainInitialEvent event, Emitter<WhiteboardMainState> emit) {
    context = event.context;
    final initialCategory = FeatureCategory(name: 'free hand', icon: Icon(Icons.free_breakfast), onTap: () {});
    emit(state.copyWith(selectedCategory: initialCategory));
  }

  FutureOr<void> _onSelectCategoryEvent(SelectCategoryEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }

  FutureOr<void> _onPanStart(PanStartEvent event, Emitter<WhiteboardMainState> emit) {
    final paint = Paint()
      ..color = state.selectedColor
      ..strokeWidth = state.selectedStroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final newPoint = DrawingPointEntity(points: [?event.points], paint: paint);

    emit(state.copyWith(currentDrawingPoint: newPoint));
  }

  FutureOr<void> _onPanUpdate(PanUpdateEvent event, Emitter<WhiteboardMainState> emit) {
    if (state.currentDrawingPoint != null) {
      final updatedPoint = state.currentDrawingPoint!.copyWith(
        points: [
          ...?state.currentDrawingPoint?.points,
          ...[?event.points],
        ],
      );

      emit(state.copyWith(currentDrawingPoint: updatedPoint));
    }
  }

  FutureOr<void> _onPanEnd(PanEndEvent event, Emitter<WhiteboardMainState> emit) {
    if (state.currentDrawingPoint != null) {
      final updatedPoints = List<DrawingPointEntity>.from(state.drawingPoint)..add(state.currentDrawingPoint!); // ← break stroke

      emit(state.copyWith(drawingPoint: updatedPoints, makeCurrentDrawingNull: true));
    }
  }

  FutureOr<void> _onToggleZoomMode(ToggleZoomMode event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(isZoomMode: !state.isZoomMode));
  }

  FutureOr<void> _onSelectColorEvent(SelectColorEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(selectedColor: event.selectedColor));
  }

  FutureOr<void> _onSelectStrokeEvent(SelectStrokeEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(selectedStroke: event.selectedStroke));
  }

  FutureOr<void> _onClearCanvas(ClearCanvasEvent event, Emitter<WhiteboardMainState> emit) {
    emit(state.copyWith(drawingPoint: [], makeCurrentDrawingNull: true));
  }

  FutureOr<void> _onTextRecognitionEvent(TextRecognitionEvent event, Emitter<WhiteboardMainState> emit) async {
    final response = await textRecognitionUseCase.call(TextRecognitionParams(imagePath: ''));
    if (response.isSuccess) {
    } else {}
  }

  FutureOr<void> _onMathRecognitionEvent(MathRecognitionEvent event, Emitter<WhiteboardMainState> emit) async {
    final response = await textRecognitionUseCase.call(TextRecognitionParams(imagePath: ''));
    if (response.isSuccess) {
    } else {}
  }
}
