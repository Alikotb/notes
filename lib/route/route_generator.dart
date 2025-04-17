
import 'package:flutter/material.dart';

import '../features/details/details.dart';
import '../features/home/home_screen.dart';
import '../features/splash/splash_screen.dart';
import 'app_route.dart';

class RouteGenerator{
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
        case AppRoute.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
        case AppRoute.details:
          return MaterialPageRoute(builder: (context) => DetailsScreen
            ());

      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );

    }
  }
}