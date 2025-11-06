import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_and_localization/screen/home.dart';
import 'package:map_and_localization/screen/maps.dart';

class MyssecondRouterDelegate extends RouterDelegate
    with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  final GlobalKey<NavigatorState> globalkey;
  bool mapo;
  MyssecondRouterDelegate(this.mapo) : globalkey = GlobalKey<NavigatorState>();
  bool _ismaps = false;
  bool get ismaps => _ismaps;
  set ismaps(bool value) {
    if (value == _ismaps) return;
    _ismaps = value;
    notifyListeners();
  }

  void showMapsPage() {
    ismaps = true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(key: ValueKey("home"), child: Home()),
        if (mapo) MaterialPage(key: ValueKey("maps"), child: Maps()),
      ],
      // onPopPage DIHAPUS. Mixin akan menanganinya.
    );
  }

  // INI ADALAH CARA YANG BENAR
  // Override method 'onDidRemovePage' dari delegate

  @override
  Future<void> setNewRoutePath(void configuration) {
    return SynchronousFuture(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => globalkey;
}
