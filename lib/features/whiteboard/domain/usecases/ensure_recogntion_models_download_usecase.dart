import 'package:inboard_personal_project/core/wrappers/api_result_wrapper.dart';
import 'package:inboard_personal_project/core/wrappers/usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart';

class EnsureRecognizationModelsDownloadUseCase implements UseCase<ApiResult<bool>?, NoParams> {
  final WhiteboardMainRepository repository;

  EnsureRecognizationModelsDownloadUseCase(this.repository);

  @override
  Future<ApiResult<bool>?> call(NoParams noParams) async {
    return await repository.ensureModelsLoad();
  }
}
