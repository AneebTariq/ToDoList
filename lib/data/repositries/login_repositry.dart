import '../modals/login_model.dart';
import '../services/login_services.dart';

class LoginRepo {
  LoginService service = LoginService();
  Future<LoginResponseModel> userLogin(
      {required String name,
      required String password,}) async {
    LoginResponseModel loginmodel = await service.userLogin(name, password);
    return loginmodel;
  }
}
