import 'dart:async';

import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';

abstract class WhiteboardMainSource {
  FutureOr<ApiResult<String>> recognizeText();
  FutureOr<ApiResult<String>> recognizeMath();
}
