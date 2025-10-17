import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:navigation_2/db/authrepo.dart';
import 'package:navigation_2/model/person.dart';
import 'package:navigation_2/screen/detail.dart';
import 'package:navigation_2/screen/form.dart';
import 'package:navigation_2/screen/home.dart';
import 'package:navigation_2/screen/login_screen.dart';
import 'package:navigation_2/screen/register_screen.dart';
import 'package:navigation_2/screen/splashscreen.dart';

class Myroute extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorkey;
  final Authrepo authrepo;
  Person? persondata;
  bool isform = false;
  List<Page> historystack = [];
  bool? isLoggedin;
  bool isregistered = false;

  Myroute(this.authrepo) : _navigatorkey = GlobalKey<NavigatorState>() {
    _init();
  }
  _init() async {
    isLoggedin = await authrepo.isLoggedin();
    notifyListeners();
  }

  List<Page> get splashstack => const [
    MaterialPage(key: ValueKey("splashpage"), child: Splashscreen()),
  ];

  List<Page> get _loggedOutStack => [
    MaterialPage(
      key: ValueKey("loginpage"),
      child: LoginScreen(
        onLogin: () {
          isLoggedin = true;
          notifyListeners();
        },
        onRegister: () {
          isregistered = true;
          Logger().d(isregistered);
          notifyListeners();
        },
      ),
    ),
    if (isregistered == true)
      MaterialPage(
        key: ValueKey("registerpage"),
        child: RegisterScreen(
          onLogin: () {
            isregistered = false;
            notifyListeners();
          },
          onRegister: () {
            isregistered = false;
            notifyListeners();
          },
        ),
      ),
  ];

  List<Page> get loggedinStack => [
    MaterialPage(
      key: const ValueKey("quotesPage"),
      child: Home(
        ontap: (data) {
          persondata = data;
          notifyListeners();
        },
        ontapform: () {
          isform = true;
          notifyListeners();
        },
        onlogout: () {
          isLoggedin = false;
          notifyListeners();
        },
      ),
    ),
    if (persondata != null)
      MaterialPage(
        key: ValueKey('detail-${persondata!.id}'),
        child: Detail(person: persondata ?? Person(0, "nama", "keahlian")),
      ),
    if (isform)
      MaterialPage(
        key: ValueKey('formscreen'),
        child: Formscreen(
          onsend: () {
            isform = false;
            notifyListeners();
          },
        ),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedin == null) {
      historystack = splashstack;
    } else if (isLoggedin == true) {
      historystack = loggedinStack;
    } else {
      historystack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historystack,
      onDidRemovePage: (page) {
        if (persondata != null) {
          if (page.key == ValueKey('detail-${persondata!.id}')) {
            persondata = null;
            notifyListeners();
          }
        }
        if (page.key == ValueKey('formscreen')) {
          isform = false;
          notifyListeners();
        }
        if (page.key == const ValueKey("RegisterPage")) {
          isregistered = false;
          notifyListeners();
        }
      },
    );
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorkey;

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
