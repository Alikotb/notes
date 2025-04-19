import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import 'custom_ink_button.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({super.key, required this.icon});
  final CustomInkButton icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppThemeHelper.card,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
            AppThemeHelper.isDarkMode
                ? Colors.black.withOpacity(0.5)
                : Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color:
          AppThemeHelper.isDarkMode
              ? Colors.black.withOpacity(0.2)
              : Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child:icon ,
      ),
    );
  }
}
