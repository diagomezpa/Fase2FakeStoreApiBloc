import 'package:fase2cleanarchitecture/data/models/product/product_model.dart';
import 'package:fase2cleanarchitecture/data/models/product/rating_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';

class ProductMapper {
  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id!,
      title: model.title!,
      price: model.price!,
      description: model.description!,
      category: model.category!,
      image: model.image!,
      rating: model.rating?.toEntity() ?? Rating(rate: 0.0, count: 0),
    );
  }
}

class ProductJsonMapper {
  static Map<String, dynamic> toJson(Product product) {
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
}
