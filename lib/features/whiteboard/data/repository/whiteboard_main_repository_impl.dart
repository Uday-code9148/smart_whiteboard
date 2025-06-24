import 'dart:async';

import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/features/whiteboard/data/sources/whiteboard_main_source.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart' show WhiteboardMainRepository;

class WhiteboardMainRepositoryImpl implements WhiteboardMainRepository {
  WhiteboardMainSource whiteboardMainSource;

  WhiteboardMainRepositoryImpl(this.whiteboardMainSource);

  @override
  FutureOr<ApiResult<String>> recognizeText() async {
    return await whiteboardMainSource.recognizeText();
  }

  @override
  FutureOr<ApiResult<String>> recognizeMath() async {
    return await whiteboardMainSource.recognizeText();
  }
}
