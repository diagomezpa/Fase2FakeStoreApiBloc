import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';

class GetCarts {
  final CartRepository repository;

  GetCarts(this.repository);

  Future<Either<Failure, List<Cart>>> call() async {
    return await repository.fetchCarts();
  }
}
