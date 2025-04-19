
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/note_model.dart';
import '../../../repo/repository.dart';

part 'important_state.dart';

class ImportantCubit extends Cubit<ImportantState> {
  Repository repository;
  ImportantCubit(this.repository) : super(ImportantInitial());
  void loadNotes() async{
    emit(ImportantInitial());
    List<NotesModel> notes = [];
    try {
      notes = (await repository.getImportantNotes());
      emit(ImportantLoaded(notes));
    } catch (e) {
      emit(ImportantError());
    }
  }

  void updateNote(NotesModel note) {
    repository.updateNote(note);
    loadNotes();
  }


  void deleteNote(int id) {
    emit(ImportantInitial());
    try {
      repository.deleteNote(id);
    } catch (e) {
      emit(ImportantError());
    }
  }

}
