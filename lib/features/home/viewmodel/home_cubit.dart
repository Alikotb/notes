import 'package:bloc/bloc.dart';
import '../../../model/note_model.dart';
import '../../../repo/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Repository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  void loadNotes() async {
    emit(HomeLoading());
    List<NotesModel> notes = [];
    try {
      notes = await repository.getAllNotes();
      emit(HomeLoaded(notes));
    } catch (e) {
      emit(HomeError());
    }
  }

  void getNoteById(int id) async {
    emit(HomeLoading());
    NotesModel? note;
    try {
      note = await repository.getNoteById(id);
      emit(HomeLoaded([note!]));
    } catch (e) {
      emit(HomeError());
    }
  }

  void updateNote(NotesModel note) {
    emit(HomeLoading());
    try {
      repository.updateNote(note);
    } catch (e) {
      emit(HomeError());
    }
  }
  void deleteNote(int id) {
    emit(HomeLoading());
    try {
      repository.deleteNote(id);
    } catch (e) {
      emit(HomeError());
    }
    }
}
