import 'package:get_it/get_it.dart';
import 'package:inboard_personal_project/core/services/local_services/recognition_service.dart';
import 'package:inboard_personal_project/features/whiteboard/data/repository/whiteboard_main_repository_impl.dart';
import 'package:inboard_personal_project/features/whiteboard/data/sources/whiteboard_main_source.dart';
import 'package:inboard_personal_project/features/whiteboard/data/sources/whiteboard_main_source_impl.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/repository/whiteboard_main_repository.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/ensure_recogntion_models_download_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/math_rec_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/domain/usecases/text_rec_usecase.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Repository
  getIt.registerLazySingleton<WhiteboardMainRepository>(() => WhiteboardMainRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<WhiteboardMainSource>(() => WhiteboardMainSourceImpl());

  // UseCase
  getIt.registerLazySingleton(() => TextRecognitionUseCase(getIt()));
  getIt.registerLazySingleton(() => RecognitionService());
  getIt.registerLazySingleton(() => MathRecognitionUseCase(getIt()));
  getIt.registerLazySingleton(() => EnsureRecognizationModelsDownloadUseCase(getIt()));

  // Bloc
  getIt.registerLazySingleton<WhiteboardMainBloc>(() => WhiteboardMainBloc(getIt(), getIt(), getIt()));
}
