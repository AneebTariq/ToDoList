
import '../../modals/home_model.dart';

abstract class HomeState {}

/// fetch TodoList State
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

/// State for AddOrUpdate
class AddOrUpdateSuccessState extends HomeState {}

class ToDoUpdateProgressState extends HomeState{}

class AddOrUpdateErrorState extends HomeState{
  String error;

  AddOrUpdateErrorState({required this.error});

  @override
  String toString() => 'DataLoadFailure{error": $error}';
}



/// State for Delete
class DeleteSuccessState extends HomeState{}

class DeleteProgressState extends HomeState{}

class DeleteErrorState extends HomeState{
  String error;

  DeleteErrorState({required this.error});

  @override
  String toString() => 'DataLoadFailure{error": $error}';
}