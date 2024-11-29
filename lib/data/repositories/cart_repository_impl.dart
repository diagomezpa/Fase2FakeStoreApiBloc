import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_endpoints.dart';
import 'package:fase2cleanarchitecture/data/models/cart_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiClient apiClient;

  CartRepositoryImpl({required this.apiClient});

  Future<Either<Failure, List<Cart>>> fetchCarts() async {
    final response = await apiClient.fetchList(
      ApiEndpoints.carts,
      (data) => CartModel.fromJson(data), // Convierte a CartModel
    );
    return response.fold(
      (failure) => Left(failure),
      (cartModels) {
        print(cartModels);
        // Convierte la lista de CartModel a Cart (entidad)
        List<Cart> carts = cartModels
            .where((model) => model != null)
            .map((model) => model!.toEntity())
            .toList();
        return Right(carts);
      },
    );
  }
}
