import 'package:flutter/material.dart';
import 'package:imagepicker/provider/home_provider.dart';
import 'package:imagepicker/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
