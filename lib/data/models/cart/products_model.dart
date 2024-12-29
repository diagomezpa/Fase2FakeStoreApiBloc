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
