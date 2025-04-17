import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({super.key});

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  Color backgroundColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
      width: screenWidth * 0.4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3B3B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Note',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              // Buttons
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.star_border,
                      color: backgroundColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        backgroundColor =
                            backgroundColor == Colors.white70
                                ? Colors.yellow
                                : Colors.white70;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            'This is a preview of the note content...\naa\naaa',
            style: TextStyle(color: Colors.white60, fontSize: 14),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
