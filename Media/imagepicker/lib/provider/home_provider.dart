import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeProvider extends ChangeNotifier {
  String? imagePath;
  XFile? filegambar;

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void setGamber(XFile? data){
    filegambar = data;
    notifyListeners();
  }
}
