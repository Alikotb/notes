import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/important/viewmodel/important_cubit.dart';

import '../../local_data_source/shared_preference.dart';
import '../../model/note_model.dart';
import '../../route/app_route.dart';
import '../../utils/color.dart';
import '../../components/note_item.dart';
import '../home/component/custom_app_button.dart';
import '../home/component/custom_ink_button.dart';
import '../home/component/swipe.dart';

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
                  'important_notes',
                  style: TextStyle(
                    color: AppThemeHelper.foreground,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CustomAppButton(
                  icon: CustomInkButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoute.home);
                    },
                    icon: Icons.arrow_back_ios_new_outlined,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            BlocBuilder<ImportantCubit, ImportantState>(
              builder: (context, state) {
                if (state is ImportantInitial) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ImportantLoaded) {
                  List<NotesModel> arrangedNotes = state.notes;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      arrangedNotes.sort(
                        (a, b) => DateTime.parse(
                          b.date,
                        ).compareTo(DateTime.parse(a.date)),
                      );
                      var note = arrangedNotes[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                          left: 8,
                          bottom: 8,
                        ),
                        child: Dismissible(
                          key: Key(note.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            remove(note.id);
                          },
                          background: SwipeBackground(),
                          child: GestureDetector(
                            onTap: () {
                              SharedPref.setBool("isEditable", false);
                              SharedPref.setBool("isVisible", true);
                              SharedPref.setBool("isUpdated", true);
                              Navigator.pushNamed(
                                context,
                                AppRoute.details,
                                arguments: note,
                              );
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
                                    updatedNote.isImportant =
                                        !updatedNote.isImportant;
                                    update(updatedNote);
                                  },
                                  isHome: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }, childCount: arrangedNotes.length),
                  );
                } else if (state is ImportantError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('An error occurred: ')),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No important notes found')),
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
