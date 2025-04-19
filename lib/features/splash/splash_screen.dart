
import 'package:flutter/material.dart';

import '../../route/app_route.dart';
import '../../utils/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRoute.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppThemeHelper.background,
      body: Center(
        child:Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
