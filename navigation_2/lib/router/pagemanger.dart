import 'dart:async';

import 'package:flutter/material.dart';

class Pagemanger extends ChangeNotifier{
  late Completer<String> _completer;

  Future<String> waitforresult() async{
    _completer = Completer<String>();
    return _completer.future;
  }

  void returndata(String value){
    return _completer.complete(value);
  }
}

//penjelasan

// final completer = Completer<String>();
// Future<String> f = completer.future;

// // f adalah janji kosong.
// print("Belum ada hasil...");

// // Beberapa detik kemudian:
// completer.complete("Sudah siap!");
// // Semua orang yang 'await f' sekarang menerima "Sudah siap!"