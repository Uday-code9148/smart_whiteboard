import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/common/enums/state_enum.dart';
import 'package:inboard_personal_project/core/utilities/calculate_bounding_box_utils.dart';
import 'package:inboard_personal_project/core/utilities/stroke_utils.dart';
import 'package:inboard_personal_project/core/wrappers/icon_with_list_wrapper.dart';
import 'package:inboard_personal_project/core/wrappers/usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/entities/drawing_point_entity.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/ensure_recogntion_models_download_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/math_rec_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/text_rec_usecase.dart';

part 'whiteboard_main_event.dart';

part 'whiteboard_main_state.dart';

class WhiteboardMainBloc extends Bloc<WhiteboardMainEvent, WhiteboardMainState> {
  final TransformationController controller = TransformationController();
  Timer? _recognitionDebounceTimer;
  late final BuildContext? context;
  final TextRecognitionUseCase textRecognitionUseCase;
  final MathRecognitionUseCase mathRecognitionUseCase;
  final EnsureRecognizationModelsDownloadUseCase ensureRecognizationModelsDownload;

  WhiteboardMainBloc(this.textRecognitionUseCase, this.mathRecognitionUseCase, this.ensureRecognizationModelsDownload)
    : super(const WhiteboardMainState()) {
    on<WhiteboardMainInitialEvent>(_onInitial);
    on<SelectCategoryEvent>(_onSelectCategoryEvent);
    on<PanStartEvent>(_onPanStart);
    on<PanUpdateEvent>(_onPanUpdate);
    on<PanEndEvent>(_onPanEnd);
    on<ToggleZoomMode>(_onToggleZoomMode);
    on<SelectColorEvent>(_onSelectColorEvent);
    on<SelectStrokeEvent>(_onSelectStrokeEvent);
    on<ClearCanvasEvent>(_onClearCanvas);
    on<EnsureRecognitionModelsDownloadEvent>(_onEnsureRecognitionModelsDownloadEvent);
    on<MathRecognitionEvent>(_onMathRecognitionEvent);
    on<TextRecognitionEvent>(_onTextRecognitionEvent);
  }

  FutureOr<void> _onInitial(WhiteboardMainInitialEvent event, Emitter<WhiteboardMainState> emit) {
    context = event.context;
    add(EnsureRecognitionModelsDownloadEvent());
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
    _recognitionDebounceTimer?.cancel();
    _recognitionDebounceTimer = Timer(Duration(milliseconds: 500), () async {
      if (state.selectedCategory?.name == 'text rec') {
        add(TextRecognitionEvent());
      } else if (state.selectedCategory?.name == 'math rec') {
        add(MathRecognitionEvent());
      }
    });
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

  FutureOr<void> _onEnsureRecognitionModelsDownloadEvent(EnsureRecognitionModelsDownloadEvent event, Emitter<WhiteboardMainState> emit) async {
    emit(state.copyWith(state: StateEnum.loading));
    final response = await ensureRecognizationModelsDownload.call(NoParams());
    if (response?.isSuccess ?? false) {
      emit(state.copyWith(isModelsDownload: response?.isSuccess, state: StateEnum.initial));
    } else {
      print('error text rec ${response?.error}');
    }
  }

  FutureOr<void> _onTextRecognitionEvent(TextRecognitionEvent event, Emitter<WhiteboardMainState> emit) async {
    final ink = StrokeUtils.buildInkFromOffsets([state.drawingPoint.last.points]);
    try {
      final response = await textRecognitionUseCase.call(TextRecognitionParams(imagePath: ink));
      print('error text rec ${response}');
      if (response?.isSuccess ?? false) {
        final drawings = state.drawingPoint;
        final lastDrawing = state.drawingPoint.last;
        drawings.removeLast();
        final position = CalculateBoundingBoxUtils.calculateBoundingBox([state.drawingPoint.last.points]);
        drawings.add(lastDrawing.copyWith(recDrawing: RecognizedWrapper<String>(response?.data ?? "Something wrong"), position: position));
        emit(state.copyWith(drawingPoint: drawings));
      } else {
        print('error text rec ${response?.error}');
      }
    } catch (ex) {
      print('error text rec ${ex}');
    }
  }

  FutureOr<void> _onMathRecognitionEvent(MathRecognitionEvent event, Emitter<WhiteboardMainState> emit) async {
    final ink = StrokeUtils.buildInkFromOffsets([state.drawingPoint.last.points]);
    final response = await mathRecognitionUseCase.call(MathRecognitionParams(imagePath: ink));
    if (response?.isSuccess ?? false) {
      final drawings = state.drawingPoint;
      final lastDrawing = state.drawingPoint.last;
      drawings.removeLast();
      final position = CalculateBoundingBoxUtils.calculateBoundingBox([state.drawingPoint.last.points]);

      drawings.add(lastDrawing.copyWith(recDrawing: RecognizedWrapper<String>(response?.data ?? "Something wrong"), position: position));
      emit(state.copyWith(drawingPoint: drawings));
    } else {
      print('error math rec ${response?.error}');
    }
  }

  @override
  Future<void> close() {
    _recognitionDebounceTimer?.cancel();
    return super.close();
  }
}
