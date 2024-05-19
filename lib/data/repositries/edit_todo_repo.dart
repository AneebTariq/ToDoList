
import '../services/edit_todo_service.dart';

class EditToDoRepo {
  EditToDoService service = EditToDoService();

  ///Add to ToDOList repo function
  Future<bool> addToDoRepo({required String todo, required int id,
        required bool status}) async {
    bool isAdded= await service.addToDoService(todo,status,id );
    return isAdded;
  }

 ///Update TodoList Repo function
  Future<bool> updateToDoRepo({required String todo, required int id,
    required bool status}) async {
   bool isUpdated= await service.updateToDoService(id,todo,status );
     return isUpdated;
  }

  /// Delete ToDoList Repo function
  Future<bool> deleteToDoRepo({required int id}) async {
   bool isDeleted= await service.deleteToDoService(id);
   return isDeleted;
  }

}





