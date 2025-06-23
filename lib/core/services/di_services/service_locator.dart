import 'package:get_it/get_it.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Repository
  // getIt.registerLazySingleton<CounterRepository>(() => CounterRepositoryImpl());

  // UseCase
  // getIt.registerLazySingleton(() => IncrementCounter(getIt()));

  // Bloc
  getIt.registerFactory(() => WhiteboardMainBloc());
}
