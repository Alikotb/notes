import 'package:flutter/material.dart';
import 'package:notes/model/note_model.dart';
import '../utils/color.dart';

class NoteItem extends StatefulWidget {
   const NoteItem({
    super.key,
    this.note,
    required this.onDelete,
    required this.onUpdate,
    this.isImportant=false,
  });

  final bool isImportant;
  final NotesModel? note;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late Color starColor;

  @override
  void initState() {
    super.initState();
    starColor = widget.note!.isImportant ? Colors.red : AppThemeHelper.icon;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      width: screenWidth * 0.4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: widget.isImportant==false?AppThemeHelper.card
            : (ColorGenerator.generateHarmoniousColors(count: 5)..shuffle()).first,
        borderRadius: BorderRadius.circular(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.note!.title,
                  style: TextStyle(
                    color: AppThemeHelper.foreground,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 32,
                    child: IconButton(
                      icon: Icon(
                        starColor == Colors.red
                            ? Icons.star
                            : Icons.star_border,
                        color: starColor,
                        size: 20,
                      ),

                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        widget.onUpdate();
                        setState(() {
                          starColor =
                              widget.note!.isImportant
                                  ? Colors.red
                                  : AppThemeHelper.icon;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppThemeHelper.icon,
                        size: 20,
                      ),
                      onPressed: () {
                        widget.onDelete();
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            widget.note!.content,
            style: TextStyle(color: AppThemeHelper.textFieldText, fontSize: 14),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
