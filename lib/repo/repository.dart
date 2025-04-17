
import '../local_data_source/local_data_source.dart';
import '../model/note_model.dart';

class Repository{
  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<int> insertNote(NotesModel note) async {
    return await databaseHelper.insertNote(note);
  }
  Future<int> updateNote(NotesModel note) async {
    return await databaseHelper.updateNote(note);
  }
  Future<int> deleteNote(String title) async {
    return await databaseHelper.deleteNote(title);
  }
  Future<NotesModel?> getNoteByTitle(String title) async {
    return await databaseHelper.getNoteByTitle(title);
  }
  Future<List<NotesModel>> getAllNotes() async {
    return await databaseHelper.getAllNotes();
  }

}