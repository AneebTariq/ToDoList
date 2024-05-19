// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginEvent {}

class AuthticateEvent extends LoginEvent {
  String name;
  String password;
  AuthticateEvent({
    required this.name,
    required this.password,
  });
}
