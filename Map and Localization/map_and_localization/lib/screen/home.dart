import 'package:flutter/material.dart';
import 'package:map_and_localization/provider/apiprovider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<ProductProvider>().getalldata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        if (value.data == null) {
          return Center(child: Text("loading.."));
        } else {
          return Scaffold(
            body: SafeArea(
              child: ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final data = value.data?[index];
                  return Card(
                    child: ListTile(
                      title: Text(data?.title ?? ""),
                      subtitle: Text(data!.description),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
