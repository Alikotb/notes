import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes/repo/repository.dart';

import '../../../model/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Repository repository;
  HomeCubit(this.repository) : super(HomeInitial());
  void loadNotes()async{
    emit(HomeLoading());
    List<NotesModel> notes = [];
    try{
      notes = await repository.getAllNotes();
      emit(HomeLoaded(notes));
    }
    catch(e){
      emit(HomeError());
    }
  }
}
