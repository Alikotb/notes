part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsLoaded extends DetailsState {
  final NotesModel note;
  DetailsLoaded(this.note);
}
final class DetailsError extends DetailsState {}
