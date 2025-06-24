import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/core/wrappers/usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart';

class MathRecognitionUseCase implements UseCase<ApiResult<String>, MathRecognitionParams> {
  final WhiteboardMainRepository repository;

  MathRecognitionUseCase(this.repository);

  @override
  Future<ApiResult<String>> call(MathRecognitionParams params) async {
    return await repository.recognizeMath();
  }
}

class MathRecognitionParams {
  final String imagePath;

  MathRecognitionParams({required this.imagePath});
}
