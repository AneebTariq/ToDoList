import 'dart:convert';
import 'package:http/http.dart';
import '../apiconstants/api_constants.dart';
import '../httpclient/http_client.dart';
import '../modals/login_model.dart';

class LoginService {

  Future<LoginResponseModel> userLogin(String name, String password,) async {
    Response response = await HttpClient.instance.postRequest(
        endPoint: ApiConstants.login,
        header: ApiConstants.getRequestHeaders(),
        data: {
          "username": name,
          "password": password,
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      LoginResponseModel model = LoginResponseModel.fromJson(json);
      return model;
    } else {
      throw ApiConstants.apiExceptions(response);
    }
  }
}
