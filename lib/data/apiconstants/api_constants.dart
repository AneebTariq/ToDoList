import 'package:http/http.dart';
import '../exceptions/exception.dart';

class ApiConstants {
  static String baseUrl = "https://dummyjson.com";

  static String login = "$baseUrl/auth/login";
  static String toDoList = "$baseUrl/todos";
  static String addToDo = "$toDoList/add";
  ////Headers////

  static Map<String, String> getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // static Map<String, String> getRequestHeadersToken(String token) {
  //   return {
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //     HttpHeaders.acceptHeader: 'application/json',
  //     HttpHeaders.authorizationHeader: 'Bearer $token'
  //   };
  // }

  static Exceptions apiExceptions(Response response) {
    if (response.statusCode == 401) {
      return UnauthorizedAccess();
    } else {
      return CommonException(
          '${response.statusCode} : ${response.reasonPhrase}');
    }
  }
}
