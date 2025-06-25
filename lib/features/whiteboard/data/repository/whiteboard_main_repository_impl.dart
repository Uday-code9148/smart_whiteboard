import 'dart:async';

import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as mlkt;
import 'package:google_mlkit_digital_ink_recognition/src/digital_ink_recognizer.dart';
import 'package:inboard_personal_project/core/services/local_services/recognition_service.dart';
import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/features/whiteboard/data/sources/whiteboard_main_source.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/enums/languages_enum.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart' show WhiteboardMainRepository;

class WhiteboardMainRepositoryImpl implements WhiteboardMainRepository {
  WhiteboardMainSource whiteboardMainSource;
  final RecognitionService _recognitionTextService;
  final RecognitionService _recognitionMathService;

  WhiteboardMainRepositoryImpl(this.whiteboardMainSource, this._recognitionTextService, this._recognitionMathService);

  @override
  Future<ApiResult<String>?> recognizeNormalText(Ink ink) async {
    try {
      final response = await _recognitionTextService.recognizeNormalText(ink);
      return ApiResult.success(response?.text ?? '');
    } catch (ex) {
      try {
        return await whiteboardMainSource.recognizeText();
      } catch (ex) {
        return ApiResult.failure(ex.toString());
      }
    }
  }

  @override
  Future<ApiResult<String>?> recognizeMathText(Ink ink) async {
    try {
      final response = await _recognitionMathService.recognizeMathText(ink);
      return ApiResult.success(response?.text ?? '');
    } catch (ex) {
      try {
        return await whiteboardMainSource.recognizeMath();
      } catch (ex) {
        return ApiResult.failure(ex.toString());
      }
    }
  }

  @override
  Future<ApiResult<bool>?> ensureModelsLoad() async {
    try {
      final results = await Future.wait([
        _recognitionTextService.ensureModelDownloaded(LanguagesEnum.english.value),
        // _recognitionMathService.ensureModelDownloaded(LanguagesEnum.math.value),
      ]);
      final bothSucceeded = results.every((result) => result == true);
      return ApiResult.success(bothSucceeded);
    } catch (ex) {
      return ApiResult.failure(ex.toString());
    }
  }
}
