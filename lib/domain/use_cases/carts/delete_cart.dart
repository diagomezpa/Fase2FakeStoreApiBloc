import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';

class DeleteCart {
  final CartRepository repository;
  DeleteCart(this.repository);

  Future<Either<Failure, Cart>> call(int cartId) async {
    return await repository.deleteCart(cartId);
  }
}
