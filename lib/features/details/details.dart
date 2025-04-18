import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:notes/features/details/viewmodel/details_cubit.dart';
import 'package:notes/local_data_source/shared_preference.dart';
import 'package:notes/route/app_route.dart';

import '../../model/note_model.dart';
import '../../utils/color.dart';

class DetailsScreen extends StatefulWidget {
  final NotesModel? note;
  const DetailsScreen({super.key,this.note});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool isVisible = SharedPref.getBool("isVisible") ?? false;
  bool isEditable = SharedPref.getBool("isEditable") ?? true;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  String? title;
  String? content;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final fabSpacing = screenHeight * 0.08;
    final fabPadding = screenHeight * 0.025;
    return Scaffold(

      backgroundColor: AppThemeHelper.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(10),
                          splashColor: AppThemeHelper.foreground.withOpacity(0.2),
                          highlightColor: AppThemeHelper.foreground.withOpacity(0.1),

                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: AppThemeHelper.foreground,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Container(
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
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isEditable = true;
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            splashColor: AppThemeHelper.foreground.withOpacity(0.2),
                            highlightColor: AppThemeHelper.foreground.withOpacity(0.1),
                            child: Icon(
                              Icons.edit,
                              color: AppThemeHelper.foreground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(12),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {
                    title = value;
                  },
                  enabled: isEditable,
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: AppThemeHelper.textFieldHint,
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: "Title",
                  ),
                  style: TextStyle(
                    color: AppThemeHelper.textFieldText,
                    fontSize: 30,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(left: 8),
                  child: TextField(
                    onChanged: (value) {
                      content = value;
                    },
                    enabled: isEditable,
                    controller: contentController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppThemeHelper.textFieldHint,
                        fontSize: 24,
                      ),
                      hintText: "Type your note here...",
                    ),
                    style: TextStyle(
                      color: AppThemeHelper.textFieldText,
                      fontSize: 22,
                    ),
                    maxLines: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isEditable,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: fabSpacing + fabPadding,
                  right: 16,
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      titleController.clear();
                      contentController.clear();
                    });
                  },
                  backgroundColor: AppThemeHelper.fabBackground,
                  foregroundColor: AppThemeHelper.fabForeground,
                  elevation: 10,
                  shape: CircleBorder(),
                  splashColor: Colors.grey,
                  child: Icon(Icons.clear, size: 35, weight: 900),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: fabPadding, right: 16),
                child: FloatingActionButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty &&
                        contentController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.redAccent,
                            ),
                            child: Text(
                              "Note can't be Empty , please enter something!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          backgroundColor: AppThemeHelper.background,
                          duration: Duration(seconds: 6),
                        ),
                      );
                      return;
                    } else {
                      final note = NotesModel(
                        title: titleController.text.trim(),
                        content: contentController.text.trim(),
                        date: DateTime.now().toString(),
                        id: SharedPref.getBool("isUpdated") == true
                            ? widget.note!.id
                            : DateTime.now().millisecondsSinceEpoch,
                      );

                      if(SharedPref.getBool("isUpdated")==false){
                      context.read<DetailsCubit>().addNote(note);
                      }else{
                        note.isImportant=widget.note!.isImportant;
                        context.read<DetailsCubit>().updateNote(note);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Note added!"),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.teal,
                          duration: Duration(seconds: 2),
                        ),
                      );

                      Navigator.pushReplacementNamed(context,AppRoute.home);
                    }
                  },

                  backgroundColor: AppThemeHelper.fabBackground,
                  foregroundColor: AppThemeHelper.fabForeground,
                  elevation: 10,
                  shape: CircleBorder(),
                  splashColor: Colors.grey,
                  child: Icon(Icons.save, size: 35, weight: 900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
