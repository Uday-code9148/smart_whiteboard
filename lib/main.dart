import 'package:flutter/material.dart';
import 'package:inboard_personal_project/core/services/di_services/app_bloc_providers_service.dart';
import 'package:inboard_personal_project/core/services/di_services/service_locator.dart';
import 'package:inboard_personal_project/features/whiteboard/presentation/screens/whiteboard_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.providers,
      child: MaterialApp(home: WhiteboardMainScreen()),
    );
  }
}
