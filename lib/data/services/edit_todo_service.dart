import 'package:http/http.dart';
import '../apiconstants/api_constants.dart';
import '../httpclient/http_client.dart';

class EditToDoService {
  /// add in ToDoList service function
  Future<bool> addToDoService(String? todo,bool? status,int? userId) async {
    Response response = await HttpClient.instance.postRequest(
      endPoint: ApiConstants.addToDo,
      header: ApiConstants.getRequestHeaders(),
      data: {
        "todo":todo,
        "completed":status,
        "userId":userId
      },
    );
    if (response.statusCode == 200) {
     print("this item is add to ToDoList:: ${response.body}");
     return true;
    } else {
      throw ApiConstants.apiExceptions(response);
    }
  }

  /// update ToDoList service function
  Future<bool> updateToDoService(int? toDoId,String? todo,bool? status) async {
    Response response = await HttpClient.instance.putRequest(
      endPoint: '${ApiConstants.toDoList}/$toDoId',
      header: ApiConstants.getRequestHeaders(),
      data: {
        "todo":todo,
        "completed":status
      },
    );
    if (response.statusCode == 200) {
      print("this item is updated in ToDoList:: ${response.body}");
      return true;
    } else {
      throw ApiConstants.apiExceptions(response);
    }
  }

  /// delete ToDoList service function
  Future<bool> deleteToDoService(int? toDoId) async {
    Response response = await HttpClient.instance.deleteRequest(
      endPoint: '${ApiConstants.toDoList}/$toDoId',
      header: ApiConstants.getRequestHeaders(),
    );
    if (response.statusCode == 200) {
      print("this item is deleted from ToDoList:: ${response.body}");
      return true;
    } else {
      throw ApiConstants.apiExceptions(response);
    }
  }
}
