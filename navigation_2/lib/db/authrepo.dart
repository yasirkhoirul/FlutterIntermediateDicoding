import 'package:navigation_2/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authrepo {
  final String statekey = 'state';
  final  String userstate = "userstate";
  Future<bool> isLoggedin()async{
      final preferences = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 2));
      return preferences.getBool(statekey)??false;
    }

    Future<bool> login() async {
      final preferences = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 2));
      return preferences.setBool(statekey, true);
    }

    Future<bool> logout() async{
      final preferences = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 2));
      return preferences.setBool(statekey, false);
    }

  Future<bool> saveUser(User user)async{
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userstate, user.tojson());
  }

  Future<bool> deleteUser()async{
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userstate, "");
  }

  Future<User?> getUser()async{
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final json = preferences.getString(userstate)??'';
    User? user;
    try {
      user = User.fromjson(json);
    } catch (e) {
      user = null;
    }
    return user;
  }

}