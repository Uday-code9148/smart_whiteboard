import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as mlkt;
import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/core/wrappers/usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart';

class MathRecognitionUseCase implements UseCase<ApiResult<String>?, MathRecognitionParams> {
  final WhiteboardMainRepository repository;

  MathRecognitionUseCase(this.repository);

  @override
  Future<ApiResult<String>?> call(MathRecognitionParams params) async {
    return await repository.recognizeMathText(params.imagePath);
  }
}

class MathRecognitionParams {
  final mlkt.Ink imagePath;

  MathRecognitionParams({required this.imagePath});
}
