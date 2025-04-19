import 'package:Noto/features/details/viewmodel/details_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../components/custome_fab.dart';
import '../../local_data_source/shared_preference.dart';
import '../../model/note_model.dart';
import '../../route/app_route.dart';
import '../../utils/color.dart';
import '../home/component/custom_app_button.dart';
import '../home/component/custom_ink_button.dart';

class DetailsScreen extends StatefulWidget {
  final NotesModel? note;

  const DetailsScreen({super.key, this.note});

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
      body: Hero(
        tag: widget.note?.id.toString() ?? "new_note",
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAppButton(
                        icon: CustomInkButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          icon: Icons.arrow_back_ios_new_outlined,
                        ),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CustomAppButton(
                            icon: CustomInkButton(
                              onTap: () {
                                setState(() {
                                  isVisible = false;
                                  isEditable = true;
                                });
                              },
                              icon: Icons.edit,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        hintText: context.tr('title'),
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
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppThemeHelper.textFieldHint,
                            fontSize: 24,
                          ),
                          hintText: context.tr('content'),
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
        ),
      ),
        floatingActionButton: Visibility(
          visible: isEditable,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: fabSpacing + fabPadding,
                      end: 16,
                    ),
                    child: CustomFab(
                      icon: Icons.clear,
                      onTap: () {
                        setState(() {
                          titleController.clear();
                          contentController.clear();
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: fabPadding,
                      end: 16,
                    ),
                    child: CustomFab(
                      icon: Icons.save,
                      onTap: () {
                        if (titleController.text.trim().isEmpty &&
                            contentController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.redAccent,
                                ),
                                child: Text(
                                  "Note can't be Empty!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              backgroundColor: AppThemeHelper.background,
                              duration: Duration(seconds: 2),
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

                          if (SharedPref.getBool("isUpdated") == false) {
                            context.read<DetailsCubit>().addNote(note);
                          } else {
                            note.isImportant = widget.note!.isImportant;
                            context.read<DetailsCubit>().updateNote(note);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Note added!"),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.teal,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, AppRoute.home);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
