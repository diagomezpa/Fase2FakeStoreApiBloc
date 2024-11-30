import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_cart.dart';

class UpdateCart {
  final CartRepository cartRepository;
  final GetCart getcart;

  UpdateCart(this.cartRepository, this.getcart);

  Future<Either<Failure, Cart>> call(int id) async {
    final cartOrFailure = await getcart(id);

    return cartOrFailure.fold(
      (failure) => Left(failure),
      (product) async => await cartRepository.updateCart(id, product),
    );
  }
}
