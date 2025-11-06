// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApi _$ProductApiFromJson(Map<String, dynamic> json) => ProductApi(
  (json['id'] as num).toInt(),
  json['title'] as String,
  (json['price'] as num).toDouble(),
  json['description'] as String,
  json['category'] as String,
  json['image'] as String,
);

Map<String, dynamic> _$ProductApiToJson(ProductApi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
    };
