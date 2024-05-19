abstract class HomeEvent {}

class ProgressEvent extends HomeEvent {}

class DataFetchEvent extends HomeEvent{
  final int? currentPage;
  final int? limit;
  DataFetchEvent(this.currentPage, this.limit,);
}

class AddOrUpdateTodoEvent extends HomeEvent {
  final bool? status;
  final String todo;
  final int? id;
  final bool isEdit;

  AddOrUpdateTodoEvent( {required this.status, required this.todo, required this.id,required this.isEdit});
}

class DeleteFromToDoEvent extends HomeEvent{
  final int? toDoId;
  DeleteFromToDoEvent({required this.toDoId});
}
class ToDoStatusEvent extends HomeEvent{}