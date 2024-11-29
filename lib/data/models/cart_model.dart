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
  final List<ArticleModel>? articles;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.articles,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        articles: List<ArticleModel>.from(
            json["products"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date?.toIso8601String(),
        "products": articles != null
            ? List<dynamic>.from(articles!.map((x) => x.toJson()))
            : null,
      };

  Cart toEntity() {
    return Cart(
      id: id,
      userId: userId,
      date: date,
      articles: articles?.map((e) => e.toEntity()).toList(),
    );
  }
}

class ArticleModel {
  final int articleId;
  final int quantity;

  ArticleModel({
    required this.articleId,
    required this.quantity,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        articleId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "articleId": articleId,
        "quantity": quantity,
      };

  Article toEntity() {
    return Article(
      articleId: articleId,
      quantity: quantity,
    );
  }
}
