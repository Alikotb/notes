import 'package:flutter/material.dart';
import 'package:notes/model/note_model.dart';

import '../../../utils/color.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.note,required this.onTap});

  final NotesModel note;
  final Function(BuildContext context, NotesModel note) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ListTile(
        onTap: () {
          onTap(context, note);
        },
        title: Text(
          note.title,
          style: TextStyle(
            color: AppThemeHelper.foreground,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          note.content.length > 50
              ? '${note.content.substring(0, 50)}...'
              : note.content,
          style: TextStyle(color: AppThemeHelper.textFieldHint, fontSize: 13),
        ),
        trailing: Text(
          note.date.substring(0, 10),
          style: TextStyle(color: AppThemeHelper.textFieldHint, fontSize: 12),
        ),
      ),
    );
  }
}
