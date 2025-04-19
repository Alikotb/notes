import 'package:Noto/features/home/component/search_card.dart';
import 'package:flutter/material.dart';


import '../../../local_data_source/shared_preference.dart';
import '../../../model/note_model.dart';
import '../../../route/app_route.dart';
import '../../../utils/color.dart';
import 'custom_ink_button.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<NotesModel> notes;
  late final List<String> searchTerms;
  late final List<NotesModel> searchList;

  CustomSearchDelegate(this.notes) {
    searchList = notes;
  }

  void onTap(BuildContext context, NotesModel note) {
    SharedPref.setBool("isEditable", false);
    SharedPref.setBool("isVisible", true);
    SharedPref.setBool("isUpdated", true);
    Navigator.pushReplacementNamed(context, AppRoute.details, arguments: note);
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
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: CustomInkButton(onTap: (){query = '';}, icon: Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return CustomInkButton(onTap: (){ close(context, null);}, icon: Icons.arrow_back);

  }

  @override
  Widget buildResults(BuildContext context) {
    List<NotesModel> matchQuery =
        searchList.where((note) {
          return note.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final note = matchQuery[index];
        return Card(
          color: AppThemeHelper.card,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: SearchCard(
            note: note,
            onTap: (context, note) => onTap(context, note),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<NotesModel> matchQuery =
        searchList.where((note) {
          return note.title.toLowerCase().contains(query.toLowerCase());
        }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final note = matchQuery[index];
        return Card(
          color: AppThemeHelper.card,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: SearchCard(
            note: note,
            onTap: (BuildContext context, NotesModel note) {
              onTap(context, note);
            },
          ),
        );
      },
    );
  }
}
