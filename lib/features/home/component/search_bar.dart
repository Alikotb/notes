import 'package:flutter/material.dart';
import 'package:notes/route/app_route.dart';

import '../../../local_data_source/shared_preference.dart';
import '../../../model/note_model.dart';
import '../../../utils/color.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<NotesModel> notes;
  late final List<String> searchTerms;
  late final List<NotesModel> searchList;

  CustomSearchDelegate(this.notes) {
    searchList = notes;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppThemeHelper.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppThemeHelper.background,
        iconTheme: IconThemeData(color: AppThemeHelper.foreground),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: AppThemeHelper.foreground),
        bodyLarge: TextStyle(color: AppThemeHelper.foreground),
        bodyMedium: TextStyle(color: AppThemeHelper.foreground),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppThemeHelper.textFieldHint),
        border: InputBorder.none,
      ),
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: AppThemeHelper.foreground,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: AppThemeHelper.foreground,
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    List<NotesModel> matchQuery = searchList.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final note = matchQuery[index];
        return  Card(
            color: AppThemeHelper.card,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child:ListTile(
          title: ListTile(
            onTap: () {
              SharedPref.setBool("isEditable", false);
              SharedPref.setBool("isVisible", true);
              SharedPref.setBool("isUpdated", true);
              Navigator.pushReplacementNamed(
                context,
                AppRoute.details,
                arguments: note,
              );
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
              style: TextStyle(
                color: AppThemeHelper.textFieldHint,
                fontSize: 13,
              ),
            ),
            trailing: Text(
              note.date.substring(0, 10) ,
              style: TextStyle(
                color: AppThemeHelper.textFieldHint,
                fontSize: 12,
              ),
            ),
          ),
        ));
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<NotesModel> matchQuery = searchList.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final note = matchQuery[index];
        return Card(
          color: AppThemeHelper.card,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            onTap: () {
              SharedPref.setBool("isEditable", false);
              SharedPref.setBool("isVisible", true);
              SharedPref.setBool("isUpdated", true);
              Navigator.pushReplacementNamed(
                context,
                AppRoute.details,
                arguments: note,
              );
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
              style: TextStyle(
                color: AppThemeHelper.textFieldHint,
                fontSize: 13,
              ),
            ),
            trailing: Text(
              note.date.substring(0, 10),
              style: TextStyle(
                color: AppThemeHelper.textFieldHint,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }

}


