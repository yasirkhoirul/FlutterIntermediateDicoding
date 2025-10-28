import 'package:flutter/material.dart';
import 'package:imagepicker/data/api/storyapi.dart';
import 'package:imagepicker/provider/home_provider.dart';
import 'package:imagepicker/provider/upload_provider.dart';
import 'package:imagepicker/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Apiservice(),),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => UploadProvider(api: context.read<Apiservice>()),)
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
