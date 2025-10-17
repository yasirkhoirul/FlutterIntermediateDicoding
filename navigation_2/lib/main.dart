import 'package:flutter/material.dart';
import 'package:navigation_2/db/authrepo.dart';
import 'package:navigation_2/provider/auth_provider.dart';
import 'package:navigation_2/router/route_delegate.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Myroute myRouterDelegate;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    final authrepo = Authrepo();
    authProvider = AuthProvider(authrepo);
    myRouterDelegate = Myroute(authrepo);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
      child: MaterialApp(
        title: 'navigation2',
        home: Router(routerDelegate: myRouterDelegate,backButtonDispatcher: RootBackButtonDispatcher(),),
      ),
    );
  }
}
