
import 'package:flutter/material.dart';

import '../../route/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoute.home);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF0b1b2b),
      body: Center(
        child:Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
