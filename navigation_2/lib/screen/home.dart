import 'package:flutter/material.dart';
import 'package:navigation_2/model/person.dart';
import 'package:navigation_2/router/pagemanger.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final Function(Person) ontap;
  final Function() ontapform;
  const Home({super.key,required this.ontap,required this.ontapform});
  @override
  Widget build(BuildContext context) {
    final data = personlis();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            final messenger = ScaffoldMessenger.of(context);
            ontapform();
            final data = await context.read<Pagemanger>().waitforresult();
            messenger.showSnackBar(SnackBar(content: Text("nama anda adalah $data")));

          },icon: Icon(Icons.settings),)
        ],
      ),
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
