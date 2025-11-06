import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstHome extends StatelessWidget {

  const FirstHome({
    super.key,
    required this.navigationShell
  });
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index){
          _onTap(context, index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'maps',
          ),
        ],
      ),
    );

  }
  void _onTap(BuildContext context, int index) {
    // 'goBranch' akan pindah ke navigator branch yang sesuai
    // 'initialLocation: true' berarti jika user kembali ke tab ini,
    // ia akan melihat halaman awal tab tersebut.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
