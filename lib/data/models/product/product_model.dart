import 'dart:convert';

import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'rating_model.dart';
import '../../enum/enum_values.dart';

class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final Category? category;
  final String? image;
  final RatingModel? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"] != null
            ? categoryValues.map[json["category"]]
            : null,
        image: json["image"],
        rating: json["rating"] != null
            ? RatingModel.fromJson(json["rating"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating?.toJson(),
      };
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MENS_CLOTHING,
  "women's clothing": Category.WOMENS_CLOTHING,
});
