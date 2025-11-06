import 'package:flutter/material.dart';
import 'package:map_and_localization/router/go_router.dart';
import 'package:map_and_localization/provider/apiprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Patroli Fakta',
      // Masukkan routerConfig
      routerConfig: router,
    );
  }
}
