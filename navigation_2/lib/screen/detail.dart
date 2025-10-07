import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';

class Detail extends StatelessWidget {
  final Person person;
  const Detail({super.key, required this.person});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("detail"),
      ),
      body: SafeArea(child: Center(child: Text(person.nama))),
    );
  }
}
