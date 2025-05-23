import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../route/app_route.dart';
import '../../../utils/color.dart';


class MoreOptionsMenu extends StatefulWidget {
  bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

    MoreOptionsMenu({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<MoreOptionsMenu> createState() => _MoreOptionsMenuState();
}

class _MoreOptionsMenuState extends State<MoreOptionsMenu> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon:  Icon(Icons.menu, color: AppThemeHelper.foreground),
      color:  AppThemeHelper.background,
      onSelected: (value) {
        if (value == 0) {
          Navigator.pushNamed(context, AppRoute.important);
          }else{
          setState(() {
            widget.isDarkMode=!widget.isDarkMode;
          });
          widget.onThemeToggle(widget.isDarkMode);

        }
      },
      itemBuilder: (context) => [
         PopupMenuItem<int>(
          value: 0,
          child: Text('important', style: TextStyle(color: AppThemeHelper.foreground)).tr(),
        ),
        PopupMenuItem<int>(
          value: 1,
          enabled: true,
          child: StatefulBuilder(
            builder: (context, setState) {
              bool localDarkMode = widget.isDarkMode;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('dark_mode', style: TextStyle(color: AppThemeHelper.foreground)).tr(),
                  Switch(
                    value: localDarkMode,
                    onChanged: (bool newValue) {
                      setState(() {
                        localDarkMode = newValue;

                      });
                      widget.onThemeToggle(newValue);
                      Navigator.pushReplacementNamed(context,AppRoute.home);
                    },
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white60,
                    activeTrackColor: Colors.green,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

}

