import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/repositories/product_repository.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.fetchProducts();
  }
}
