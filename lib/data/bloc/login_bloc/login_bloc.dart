import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modals/login_model.dart';
import '../../repositries/login_repositry.dart';
import '../../sharepref/shareprefrence.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LonigState> {
  LoginRepo loginRepository = LoginRepo();
  LoginResponseModel? loginModel;
  SharedPrefClient sharepref = SharedPrefClient();
   LoginBloc(super.initialState);

  @override
  Stream<LonigState> mapEventToState(LoginEvent event) async* {
    if (event is AuthticateEvent) {
      yield ProgressState();
      try {
        loginModel = await loginRepository.userLogin(
            name: event.name, password: event.password,);
        print('loginModel response:: $loginModel');
        if (loginModel?.token != null) {
          print('loginModel response:: ${loginModel?.token}');
          await sharepref.setUser(loginModel!);
          yield LoginSuccessState(loginDetails: loginModel);
        } else {
          yield ErrorState(error: 'Something went wrong');
        }
      } catch (e) {
        yield ErrorState(error: "User not Found $e");
      }
    }
  }
}
