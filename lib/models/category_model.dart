// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  String name;
  List<String> subcategoeies;

  Category({
    required this.name,
    required this.subcategoeies,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategoeies: List<String>.from(json["subcategoeies"].map((x) => x)),
      );
}
