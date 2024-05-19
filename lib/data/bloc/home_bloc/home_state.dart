
import '../../modals/home_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class ProgressState extends HomeState {}

class DataLoadedState extends HomeState {
  ToDoListModel toDoListModel;
  DataLoadedState({
    required this.toDoListModel,
  });
}

class ErrorState extends HomeState {
  String error;

  ErrorState({required this.error});

  @override
  String toString() => 'DataLoadFailure{error": $error}';
}

class AddOrUpdateSuccessState extends HomeState {}

class ToDoStatusState extends HomeState{}