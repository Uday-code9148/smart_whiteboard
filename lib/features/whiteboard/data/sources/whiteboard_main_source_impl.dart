import 'dart:async';

import 'package:inboard_personal_project/core/exceptions/exception.dart';
import 'package:inboard_personal_project/core/services/network_service/api_service.dart' show GenericApiService;
import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/features/whiteboard/data/sources/whiteboard_main_source.dart';

class WhiteboardMainSourceImpl extends GenericApiService implements WhiteboardMainSource {
  WhiteboardMainSourceImpl() : super();

  @override
  FutureOr<ApiResult<String>> recognizeText() async {
    final result = await super.get<String>(url: "https://api.example.com/data");
    return result;
  }

  @override
  FutureOr<ApiResult<String>> recognizeMath() async {
    final result = await super.get<String>(url: "https://api.example.com/data");
    return result;
  }
}
