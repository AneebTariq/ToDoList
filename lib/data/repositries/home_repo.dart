import '../modals/home_model.dart';
import '../services/home_service.dart';

class HomeRepo {
  HomeService homeService = HomeService();
  Future<ToDoListModel> getToDoList({int? page,int? limit}) async {
    ToDoListModel toDoListModel = await homeService.homeServiceToDoList(page,limit);
    return toDoListModel;
  }
}
