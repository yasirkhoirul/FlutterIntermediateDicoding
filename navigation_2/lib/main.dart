import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';
import 'package:navigation_2/router/route.dart';
import 'package:navigation_2/screen/detail.dart';
import 'package:navigation_2/screen/home.dart';

void main(List<String> args) {
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navigation2',
      home: Router(routerDelegate: Myroute(GlobalKey<NavigatorState>()),backButtonDispatcher: RootBackButtonDispatcher(),),
    );
  }
}
