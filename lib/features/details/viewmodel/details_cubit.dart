import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/note_model.dart';
import '../../../repo/repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  Repository? repo;

  DetailsCubit(this.repo) : super(DetailsInitial());

  void getNoteByIde(int id) async {
    emit(DetailsLoading());
    NotesModel? note;
    try {
      note = await repo!.getNoteById(id);
      emit(DetailsLoaded(note!));
    } catch (e) {
      emit(DetailsError());
    }
  }

  void updateNote(NotesModel note) {
    emit(DetailsLoading());
    try {
      repo!.updateNote(note);
    } catch (e) {
      emit(DetailsError());
    }
  }
  void addNote(NotesModel note) {
    emit(DetailsLoading());
    try {
      repo!.addNote(note);
    } catch (e) {
      emit(DetailsError());
    }
  }

}