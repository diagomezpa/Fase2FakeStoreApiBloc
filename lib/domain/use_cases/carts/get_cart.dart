import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';

class GetCart {
  final CartRepository cartRepository;
  GetCart(this.cartRepository);

  Future<Either<Failure, Cart>> call(int id) async {
    return await cartRepository.fetchCartById(id);
  }
}
