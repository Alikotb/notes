

import 'package:flutter/material.dart';

import '../utils/color.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({super.key,required this.icon,required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab-home',
      onPressed: () {
        onTap();
      },
      backgroundColor: AppThemeHelper.fabBackground,
      foregroundColor: AppThemeHelper.fabForeground,
      elevation: 10,
      shape:  CircleBorder(),
      splashColor: Colors.grey,
      child:  Icon(icon, size: 35, weight: 900),
    );
  }
}
