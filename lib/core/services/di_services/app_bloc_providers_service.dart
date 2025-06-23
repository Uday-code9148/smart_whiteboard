import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/blocs/whiteboard_main_bloc/whiteboard_main_bloc.dart';
import 'service_locator.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [BlocProvider<WhiteboardMainBloc>(create: (_) => getIt<WhiteboardMainBloc>())];
}
