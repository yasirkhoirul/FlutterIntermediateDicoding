import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:navigation_2/db/authrepo.dart';
import 'package:navigation_2/model/user.dart';

class AuthProvider extends ChangeNotifier {
  final Authrepo authrepostory;
  AuthProvider(this.authrepostory);
  bool isloadinglogin = false;
  bool isloadinglogout = false;
  bool isloadingregister = false;
  bool isloggedin = false;

  Future<bool> login(User user) async {
    isloadinglogin = true;
    notifyListeners();

    final userState = await authrepostory.getUser();
    Logger().d(userState);
    if (user == userState) {
      await authrepostory.login();
    }
    isloggedin = await authrepostory.isLoggedin();
    isloadinglogin = false;
    notifyListeners();

    return isloggedin;
  }

  Future<bool> signout()async{
    isloadinglogout = false;
    notifyListeners();

    final logout = await authrepostory.logout();

    if (logout) {
      await authrepostory.deleteUser();
    }

    isloggedin = await authrepostory.isLoggedin();

    isloadinglogout =false;
    notifyListeners();

    return !isloggedin;
  }

  Future<bool> saveUser(User user) async {
    isloadingregister = true;
    notifyListeners();
    final userState = await authrepostory.saveUser(user);
    isloadingregister = false;
    notifyListeners();
    return userState;
  }
}
