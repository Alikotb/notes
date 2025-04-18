
import '../local_data_source/local_data_source.dart';
import '../model/note_model.dart';

class Repository{
  static final DatabaseHelper _databaseHelper = DatabaseHelper();

  static Repository? _instance;

  Repository._internal();

  static Repository getInstance()  {
    _instance ??= Repository._internal();
    return _instance!;
  }



  Future<void> addNote(NotesModel note) async {
    await _databaseHelper.insertNote(note);
    getAllNotes();
  }

  Future<void> updateNote(NotesModel note) async {
    await _databaseHelper.updateNote(note);
    getAllNotes();
  }
  Future<void> deleteNote(int id) async {
     await _databaseHelper.deleteNote(id);
     getAllNotes();
  }
  Future<NotesModel?> getNoteById(int id) async {
    return await _databaseHelper.getNoteById(id);
  }
  Future<List<NotesModel>> getAllNotes() async {
    return await _databaseHelper.getAllNotes();
  }
  Future<List<NotesModel>> getImportantNotes() async {
    return await _databaseHelper.getImportantNotes();
  }


}