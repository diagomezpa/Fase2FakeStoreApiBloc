import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, Product>> call(int productId) async {
    return await repository.deleteProduct(productId);
  }
}
