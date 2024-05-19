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

class ErrorState extends LonigState {
  String error;

  ErrorState({required this.error});

  @override
  String toString() => 'LoginFailure{error": $error}';
}
