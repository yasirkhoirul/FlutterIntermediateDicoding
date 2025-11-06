import 'package:flutter/material.dart';
import 'package:map_and_localization/api.dart';

class ProductProvider extends ChangeNotifier {
  final api = GetAPi();
  String message = '';
  List<ProductApi>? data;
  getalldata() async {
    try {
      final datas = await api.getallproduct();
      if (datas.isNotEmpty) {
        data = datas;
        message = "sukses";
      } else {
        message = "gagal";
      }
    } catch (e) {
      message = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
