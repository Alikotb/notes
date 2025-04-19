import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/details/details.dart';
import '../features/details/viewmodel/details_cubit.dart';
import '../features/home/home_screen.dart';
import '../features/home/viewmodel/home_cubit.dart';
import '../features/important/important.dart';
import '../features/important/viewmodel/important_cubit.dart';
import '../features/splash/splash_screen.dart';
import '../model/note_model.dart';
import '../repo/repository.dart';
import 'app_route.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case AppRoute.home:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) =>
              HomeCubit(Repository.getInstance())
                ..loadNotes(),
              child: HomeScreen(),
            ));
      case AppRoute.important:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => ImportantCubit(Repository.getInstance())..loadNotes(),
              child: ImportantScreen(),
            ));
      case AppRoute.details:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => DetailsCubit(Repository.getInstance()),
              child: DetailsScreen(note: settings.arguments as NotesModel?),
            ));
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}