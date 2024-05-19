import 'package:shared_preferences/shared_preferences.dart';
import '../modals/login_model.dart';

class SharedPrefClient {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String tokenKey = 'token';

  Future<bool> isUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userToken = sharedPref.getString(tokenKey);
    return userToken != null && userToken.isNotEmpty;
  }

  Future<void> setUser(LoginResponseModel user) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(idKey, user.id!); // Assuming user.id is not null
    await sharedPref.setString(nameKey, "${user.username}");
    await sharedPref.setString(tokenKey, "${user.token}");
    print('Saved user: ${user.username}, ${user.token}');
  }

  Future<LoginResponseModel?> getUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    final int? id = sharedPref.getInt(idKey);
    final String? name = sharedPref.getString(nameKey);
    final String? token = sharedPref.getString(tokenKey);

    if (id != null && name != null && token != null) {
      return LoginResponseModel(id: id, username: name, token: token);
    }
    return null; // Return null if user is not found
  }

  Future<void> clearUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove(idKey);
    await sharedPref.remove(nameKey);
    await sharedPref.remove(emailKey);
    await sharedPref.remove(tokenKey);
  }

  Future<int?> getUserId() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getInt(idKey);
  }
}
