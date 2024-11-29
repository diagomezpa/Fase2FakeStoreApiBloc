import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';

import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, List<Cart>>> fetchCarts();
  //Future<Either<Failure, Cart>> fetchCartById(int id);
  //Future<Either<Failure, Cart>> createCart(Cart cart);
  //Future<Either<Failure, Cart>> updateCart(int id, Cart cart);
  //Future<Either<Failure, Cart>> deleteCart(int id);
}
