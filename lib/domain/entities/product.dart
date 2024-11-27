class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final String image;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
}

enum Category { ELECTRONICS, JEWELERY, MENS_CLOTHING, WOMENS_CLOTHING }

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });
}
