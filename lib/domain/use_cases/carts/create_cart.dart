import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';

class CreateCart {
  final CartRepository repository;

  CreateCart(this.repository);

  Future<Either<Failure, Cart>> call(Cart cart) async {
    return await repository.createCart(cart);
  }
}
