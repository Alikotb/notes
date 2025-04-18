import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/home/viewmodel/home_cubit.dart';
import 'package:notes/local_data_source/shared_preference.dart';
import 'package:notes/route/app_route.dart';

import '../../model/note_model.dart';
import '../../repo/repository.dart';
import '../../utils/color.dart';
import 'component/more_options_menu.dart';
import '../../components/note_item.dart';
import 'component/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool isDarkMode = AppThemeHelper.isDarkMode;

  void _toggleDarkMode(bool newValue) {
    setState(() {
      isDarkMode = newValue;
      SharedPref.setBool("isDarkMode", newValue);
    });
  }
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadNotes();
  }

  void remove(int id) async {
    context.read<HomeCubit>().deleteNote(id);
    context.read<HomeCubit>().loadNotes();
  }
  void update(NotesModel note) async {
    context.read<HomeCubit>().updateNote(note);
    context.read<HomeCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeHelper.background,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppThemeHelper.background,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Notes",
            style: TextStyle(
              color: AppThemeHelper.foreground,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
          actions: [
            IconButton(
              onPressed: () async {
                final notes = await Repository.getInstance().getAllNotes();
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(notes),
                );
              },
              icon: const Icon(Icons.search),
              color: AppThemeHelper.foreground,
            ),

            MoreOptionsMenu(
              isDarkMode: isDarkMode,
              onThemeToggle: _toggleDarkMode,
            ),
          ],
      ),

      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                      onTap: () {
                        SharedPref.setBool("isEditable", false);
                        SharedPref.setBool("isVisible", true);
                        SharedPref.setBool("isUpdated", true);
                        Navigator.pushNamed(context, AppRoute.details,arguments: state.notes[index]);
                      },
                      child: NoteItem(note:state.notes[index], onDelete: () {
                        remove(state.notes[index].id);
                      },
                        onUpdate: () {
                        NotesModel updateNote=state.notes[index];
                        updateNote.isImportant=!updateNote.isImportant;
                          update(updateNote);
                        },
                        isImportant: state.notes[index].isImportant,

                      ),
                    );
                  }, childCount: state.notes.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                  ),
                );
              }else{
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03,
        ),
        child: FloatingActionButton(
          onPressed: () {
            SharedPref.setBool("isEditable", true);
            SharedPref.setBool("isVisible", false);
            SharedPref.setBool("isUpdated", false);
            Navigator.pushReplacementNamed(context, AppRoute.details);
          },
          backgroundColor: AppThemeHelper.fabBackground,
          foregroundColor: AppThemeHelper.fabForeground,
          elevation: 10,
          shape: const CircleBorder(),
          splashColor: Colors.grey,
          child: const Icon(Icons.add, size: 35, weight: 900),
        ),
      ),
    );
  }
}
