import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';
import 'package:navigation_2/router/pagemanger.dart';
import 'package:navigation_2/screen/detail.dart';
import 'package:navigation_2/screen/form.dart';
import 'package:navigation_2/screen/home.dart';
import 'package:provider/provider.dart';

class Myroute extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorkey;
  Myroute(this._navigatorkey);
  Person? persondata;
  bool isform = false;

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
            ontapform: (){
              isform = true;
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
      ],
      onDidRemovePage: (page) {
        if (persondata!=null) {
          
          if (page.key == ValueKey('detail-${persondata!.id}')) {
            persondata = null;
            notifyListeners();
          }
        }
        if (page.key == ValueKey('formscreen')) {
          isform = false;
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
