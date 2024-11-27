import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/repositories/product_repository.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> call(int id) async {
    return await repository.fetchProductById(id);
  }
}
