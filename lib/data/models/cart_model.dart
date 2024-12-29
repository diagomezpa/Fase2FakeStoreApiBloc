import 'dart:convert';
import '../../domain/entities/cart.dart';

List<CartModel> cartsFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartsToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String cartToJson(CartModel data) => json.encode(data.toJson());

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

class ProductsModel {
  final int productId;
  final int quantity;

  ProductsModel({
    required this.productId,
    required this.quantity,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
