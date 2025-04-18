import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/important/viewmodel/important_cubit.dart';

import '../../local_data_source/shared_preference.dart';
import '../../model/note_model.dart';
import '../../route/app_route.dart';
import '../../utils/color.dart';
import '../../components/note_item.dart';
class ImportantScreen extends StatefulWidget {
  const ImportantScreen({super.key});

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  void update(NotesModel note) async {
    context.read<ImportantCubit>().updateNote(note);
    context.read<ImportantCubit>().loadNotes();
  }

  @override
  void initState() {
    super.initState();
    context.read<ImportantCubit>().loadNotes();
  }

  void remove(int id) async {
    context.read<ImportantCubit>().deleteNote(id);
    context.read<ImportantCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeHelper.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: false,
              pinned: false,
              floating: false,
              backgroundColor: AppThemeHelper.background,
              title: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Important",
                  style: TextStyle(
                    color: AppThemeHelper.foreground,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppThemeHelper.card,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppThemeHelper.isDarkMode
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppThemeHelper.isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoute.home);
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
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            BlocBuilder<ImportantCubit, ImportantState>(
              builder: (context, state) {
                if (state is ImportantInitial) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is ImportantLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var note = state.notes[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
                          child: Dismissible(
                            key: Key(note.id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              remove(note.id);
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                SharedPref.setBool("isEditable", false);
                                SharedPref.setBool("isVisible", true);
                                SharedPref.setBool("isUpdated", true);
                                Navigator.pushNamed(context, AppRoute.details, arguments: note);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: NoteItem(
                                    isImportant: note.isImportant,
                                    note: note,
                                    onDelete: () => remove(note.id),
                                    onUpdate: () {
                                      NotesModel updatedNote = note;
                                      updatedNote.isImportant = !updatedNote.isImportant;
                                      update(updatedNote);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.notes.length,
                    ),
                  );
                } else if (state is ImportantError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('An error occurred: '),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No important notes found'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
