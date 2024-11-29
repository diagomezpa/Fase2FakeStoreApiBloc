class Cart {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<Article>? articles;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.articles,
  });
}

class Article {
  int articleId;
  int quantity;

  Article({
    required this.articleId,
    required this.quantity,
  });
}
