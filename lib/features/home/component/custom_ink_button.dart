
import 'package:flutter/material.dart';

import '../../../utils/color.dart';

class CustomInkButton extends StatelessWidget {
  const CustomInkButton({super.key,required this.onTap,required this.icon});
   final VoidCallback onTap ;
   final  IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      borderRadius: BorderRadius.circular(10),
      splashColor: AppThemeHelper.foreground.withOpacity(0.2),
      highlightColor: AppThemeHelper.foreground.withOpacity(0.1),
      child: Icon(
        icon,
        color: AppThemeHelper.foreground,
      ),
    );
  }
}

