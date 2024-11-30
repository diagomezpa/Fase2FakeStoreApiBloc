class Cart {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<Products>? products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
}

class Products {
  int productId;
  int quantity;

  Products({
    required this.productId,
    required this.quantity,
  });
}
