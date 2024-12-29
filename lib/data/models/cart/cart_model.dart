import 'dart:convert';
import '../../../domain/entities/cart.dart';
import 'products_model.dart';

class CartModel {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<ProductsModel>? products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<ProductsModel>.from(
            json["products"].map((x) => ProductsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date?.toIso8601String(),
        "products": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : null,
      };
}
