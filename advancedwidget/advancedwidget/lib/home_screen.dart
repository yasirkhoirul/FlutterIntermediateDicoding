import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<int> angka = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  //GlobalKey adalah "pegangan" untuk memerintah AnimatedList dari luar (misalnya, dari Tombol +).
  final globallistkey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        child: IconButton(
          onPressed: () {
            final randomangka = Random().nextInt(100);
            const index = 0;
            angka.insert(index, randomangka);
            globallistkey.currentState?.insertItem(index);
          },
          icon: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.amber,
          child: AnimatedList(
            
            key: globallistkey,
            initialItemCount: angka.length,
            itemBuilder: (context, index, animation) {
              
              //animation adalah "mesin" yang diberikan oleh AnimatedList ke setiap item agar item tersebut
              //tahu cara menganimasikan dirinya sendiri (dalam kasus ini, bergeser).
              return MyItem(
                item: angka[index],
                animation: animation,
                ondelete: () {
                  final item = angka.removeAt(index);
                  globallistkey.currentState?.removeItem(

                    index,
                    duration: Duration(milliseconds: 300),
                    (context, animation) => MyItem(
                      item: item,
                      animation: animation,
                      ondelete: () {},
                    ),
                  );
                },
              );
              //nilainya berubah dari 0.0 (awal) menjadi 1.0 (akhir) selama durasi tertentu.
            },
          ),
        ),
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final Function() ondelete;
  final int item;
  final Animation<double> animation;
  const MyItem({
    super.key,
    required this.item,
    required this.animation,
    required this.ondelete,
  });

  @override
  Widget build(BuildContext context) {
    final curvedanomation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );
    return SlideTransition(
      
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(curvedanomation),
      child: Card(
        color: Colors.primaries[item % Colors.primaries.length],
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Number $item"),
              IconButton(
                onPressed: ondelete,
                icon: const Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
