import 'dart:convert';

import 'package:fase2cleanarchitecture/domain/entities/product.dart';

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

  Product toEntity() {
    return Product(
      id: id!,
      title: title!,
      price: price!,
      description: description!,
      category: category!,
      image: image!,
      rating: rating?.toEntity() ?? Rating(rate: 0.0, count: 0),
    );
  }
}

class RatingModel {
  final double? rate;
  final int? count;

  RatingModel({
    this.rate,
    this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  Rating toEntity() {
    return Rating(
      rate: rate!,
      count: count!,
    );
  }
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MENS_CLOTHING,
  "women's clothing": Category.WOMENS_CLOTHING,
});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// Convierte Product (entidad) a ProductModel y luego a JSON
Map<String, dynamic> productModelToJson(Product product) {
  return ProductModel(
    id: product.id,
    title: product.title,
    price: product.price,
    description: product.description,
    category: product.category,
    image: product.image,
    rating: RatingModel(
      rate: product.rating.rate,
      count: product.rating.count,
    ),
  ).toJson();
}
