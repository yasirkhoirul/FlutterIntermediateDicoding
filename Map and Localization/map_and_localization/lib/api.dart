import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'api.g.dart';

class GetAPi {
  Future<List<ProductApi>> getallproduct() async {
    final url = "https://fakestoreapi.com/products";
    final data = await http.get(Uri.parse(url));
    if (data.statusCode == 200) {
      List<dynamic> datatolist = jsonDecode(data.body);
      List<ProductApi> dataready = datatolist
          .map((e) => ProductApi.fromjson(e))
          .toList();
      return dataready;
    } else {
      throw Exception("terjadi kesalahan ${data.statusCode}");
    }
  }
}

@JsonSerializable()
class ProductApi {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  ProductApi(
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  );

  factory ProductApi.fromjson(Map<String, dynamic> json) =>
      _$ProductApiFromJson(json);
  Map<String, dynamic> tojson() => _$ProductApiToJson(this);
}
