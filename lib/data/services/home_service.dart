import 'dart:convert';
import 'package:http/http.dart';
import '../../config/utils/helper.dart';
import '../apiconstants/api_constants.dart';
import '../httpclient/http_client.dart';
import '../modals/home_model.dart';

class HomeService {
  Future<ToDoListModel> homeServiceToDoList(int? page, int? limit) async {
    Response response = await HttpClient.instance.getRequest(
      endPoint: '${ApiConstants.toDoList}?page=$page&limit=$limit',
      header: ApiConstants.getRequestHeaders(),
    );
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        ToDoListModel toDoListModel = ToDoListModel.fromJson(json);
        return toDoListModel;
      } catch (e) {
        print('error in calling todos by id:: $e');
        showToast('$e', false);
        throw ApiConstants.apiExceptions(response);
      }
    } else {
      showToast('$response', false);
      throw ApiConstants.apiExceptions(response);
    }
  }
}
