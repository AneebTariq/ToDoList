import '../../modals/login_model.dart';

abstract class LonigState {}

class InitState extends LonigState {}

class LoginSuccessState extends LonigState {
  LoginResponseModel? loginDetails;
  LoginSuccessState({
    required this.loginDetails,
  });
}

class ProgressState extends LonigState {}

class LoginErrorState extends LonigState {
  String error;

  LoginErrorState({required this.error});

  @override
  String toString() => 'LoginFailure{error": $error}';
}
