import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';
import 'package:navigation_2/screen/detail.dart';
import 'package:navigation_2/screen/home.dart';

class Myroute extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorkey;
  Myroute(this._navigatorkey);
  Person? persondata;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey("home"),
          child: Home(
            ontap: (data) {
              persondata = data;
              notifyListeners();
            },
          ),
        ),
        if (persondata != null)
          MaterialPage(
            key: ValueKey('detail-${persondata!.id}'),
            child: Detail(person: persondata ?? Person(0, "nama", "keahlian")),
          ),
      ],
      onDidRemovePage: (page) {
        if (page.key == ValueKey('detail-${persondata!.id}')) {
          persondata = null;
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
