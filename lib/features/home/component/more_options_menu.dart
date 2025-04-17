import 'package:flutter/material.dart';

class MoreOptionsMenu extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const MoreOptionsMenu({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      color: const Color(0xFF3B3B3B),
      onSelected: (value) {
        if (value == 0) {

        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text("Important", style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem<int>(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode", style: TextStyle(color: Colors.white)),
              Switch(
                value: isDarkMode,
                onChanged: onThemeToggle,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white60,
              ),
            ],
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