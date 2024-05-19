abstract class HomeEvent {}
/// DataFetchEvent
class DataFetchEvent extends HomeEvent{
  final int? currentPage;
  final int? limit;
  DataFetchEvent(this.currentPage, this.limit,);
}
/// AddOrUpdateTodoEvent
class AddOrUpdateTodoEvent extends HomeEvent {
  final bool? status;
  final String todo;
  final int? id;
  final bool isEdit;

  AddOrUpdateTodoEvent( {required this.status, required this.todo, required this.id,required this.isEdit});
}
/// DeleteFromToDoEvent
class DeleteFromToDoEvent extends HomeEvent{
  final int? toDoId;
  DeleteFromToDoEvent({required this.toDoId});
}
