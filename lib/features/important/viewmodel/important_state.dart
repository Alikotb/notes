part of 'important_cubit.dart';

sealed class ImportantState {}

final class ImportantInitial extends ImportantState {}

final class ImportantLoaded extends ImportantState {
  final List<NotesModel> notes;
  ImportantLoaded(this.notes);
}

final class ImportantError extends ImportantState {

}
