import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/core/wrappers/usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart';

class TextRecognitionUseCase implements UseCase<ApiResult<String>, TextRecognitionParams> {
  final WhiteboardMainRepository repository;

  TextRecognitionUseCase(this.repository);

  @override
  Future<ApiResult<String>> call(TextRecognitionParams params) async {
    return await repository.recognizeText();
  }
}

class TextRecognitionParams {
  final String imagePath;

  TextRecognitionParams({required this.imagePath});
}
