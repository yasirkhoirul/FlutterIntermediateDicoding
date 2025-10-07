import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_2/router/pagemanger.dart';
import 'package:provider/provider.dart';

class Formscreen extends StatefulWidget{
  final void Function() onsend;
  const Formscreen({super.key,required this.onsend});
  @override
  State<Formscreen> createState() => _FormscreenState();
}

class _FormscreenState extends State<Formscreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textcontroller = TextEditingController();
    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          children: [
            TextField(
              controller:  _textcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("masukkan text")
              ),
            ),
            SizedBox(height: 5,),
            OutlinedButton(onPressed: (){
              final data = _textcontroller.text;
              widget.onsend();
              context.read<Pagemanger>().returndata(data);
            }, child: Text("kirim"))
          ],
        ),
      )),
    );
  }
}