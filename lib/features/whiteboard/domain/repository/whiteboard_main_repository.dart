import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';

abstract class WhiteboardMainRepository {
  Future<ApiResult<bool>?> ensureModelsLoad();

  Future<ApiResult<String>?> recognizeMathText(Ink ink);

  Future<ApiResult<String>?> recognizeNormalText(Ink ink);
}
