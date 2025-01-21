import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_endpoints.dart';
import 'package:fase2cleanarchitecture/data/models/cart/cart_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';
import 'package:fase2cleanarchitecture/data/mappers/cart/cart_mapper.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiClient apiClient;

  CartRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Cart>>> fetchCarts() async {
    final response = await apiClient.fetchList(
      ApiEndpoints.carts,
      (data) => CartModel.fromJson(data), // Convierte a CartModel
    );
    return response.fold(
      (failure) => Left(failure),
      (cartModels) {
        List<Cart> carts = cartModels
            .where((model) => model != null)
            .map((model) => CartMapper.toEntity(model!))
            .toList();
        return Right(carts);
      },
    );
  }

  @override
  Future<Either<Failure, Cart>> fetchCartById(int id) async {
    final response = await apiClient.fetchItem(
      ApiEndpoints.cartById(id),
      (data) => CartModel.fromJson(data), // Convierte a ProductModel
    );

    return response.fold(
      (failure) => Left(failure),
      (cartModel) {
        return Right(CartMapper.toEntity(cartModel));
      },
    );
  }

  @override
  Future<Either<Failure, Cart>> createCart(Cart cart) async {
    final response = await apiClient.createItem(
      ApiEndpoints.carts,
      CartMapper.toJson(cart),
      (data) => CartModel.fromJson(data), // Convierte a CartModel
    );

    return response.fold(
      (failure) => Left(failure),
      (cartModel) {
        return Right(CartMapper.toEntity(cartModel));
      },
    );
  }

  @override
  Future<Either<Failure, Cart>> deleteCart(int id) async {
    final response = await apiClient.deleteItem(
      ApiEndpoints.cartById(id),
      (data) => CartModel.fromJson(data), // Convierte a CartModel
    );

    return response.fold(
      (failure) => Left(failure),
      (cartModel) {
        return Right(CartMapper.toEntity(cartModel));
      },
    );
  }

  @override
  Future<Either<Failure, Cart>> updateCart(int id, Cart cart) async {
    final response = await apiClient.updateItem(
      ApiEndpoints.cartById(id),
      CartMapper.toJson(cart),
      (data) => CartModel.fromJson(data), // Convierte a CartModel
    );

    return response.fold(
      (failure) => Left(failure),
      (cartModel) {
        return Right(CartMapper.toEntity(cartModel));
      },
    );
  }
}
