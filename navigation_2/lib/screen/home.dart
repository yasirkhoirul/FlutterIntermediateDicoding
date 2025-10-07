import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';

class Home extends StatelessWidget {
  final Function(Person) ontap;
  const Home({super.key,required this.ontap});
  @override
  Widget build(BuildContext context) {
    final data = personlis();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) => Listtileitem(data: data[index],ontap:(data) => ontap(data),),
          itemCount: data.length,
        ),
      ),
    );
  }
}

class Listtileitem extends StatelessWidget {
  final Function(Person) ontap;
  final Person data;
  const Listtileitem({super.key, required this.data,required this.ontap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        ontap(data);
      },
      child: ListTile(title: Text(data.nama), subtitle: Text(data.keahlian)));
  }
}
