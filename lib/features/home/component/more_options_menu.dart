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
          child: Text("Important", style: TextStyle(color: AppThemeHelper.foreground)),
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
                   Text("Dark Mode", style: TextStyle(color: AppThemeHelper.foreground)),
                  Switch(
                    value: localDarkMode,
                    onChanged: (bool newValue) {
                      setState(() {
                        localDarkMode = newValue;

                      });
                      widget.onThemeToggle(newValue);
                      Navigator.pop(context);
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




























/*   showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF252525),
              title: const Text("Set Importance", style: TextStyle(color: Colors.white)),
              content: const Text("Here you can select importance level.", style: TextStyle(color: Colors.white70)),
              actions: [
                TextButton(
                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );*/