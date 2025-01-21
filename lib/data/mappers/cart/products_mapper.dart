import 'package:fase2cleanarchitecture/data/models/cart/products_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';

class ProductsMapper {
  static Products toEntity(ProductsModel model) {
    return Products(
      productId: model.productId,
      quantity: model.quantity,
    );
  }
}
