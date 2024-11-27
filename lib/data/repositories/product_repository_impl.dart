import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_endpoints.dart';
import 'package:fase2cleanarchitecture/data/models/product_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    final response = await apiClient.createItem(
      ApiEndpoints.products,
      productModelToJson(
          product), // Convierte Product (entidad) a ProductModel y luego a JSON
      (data) => ProductModel.fromJson(data),
    );
    print('response ' + response.toString());
    return response.fold(
      (failure) => Left(failure),
      (productModel) {
        print('productModel ' + productModel.toString());
        // Convierte ProductModel a Product (entidad)
        return Right(productModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) async {
    final response = await apiClient.deleteItem(
      ApiEndpoints.productById(id),
      (data) => ProductModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (productModel) => Right(productModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Product>> fetchProductById(int id) async {
    final response = await apiClient.fetchItem(
      ApiEndpoints.productById(id),
      (data) => ProductModel.fromJson(data), // Convierte a ProductModel
    );

    return response.fold(
      (failure) => Left(failure),
      (productModel) {
        // Convierte ProductModel a Product (entidad)
        return Right(productModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, List<Product>>> fetchProducts() async {
    final response = await apiClient.fetchList(
      ApiEndpoints.products,
      (data) => ProductModel.fromJson(data), // Convierte a ProductModel
    );
    //print(response);
    return response.fold(
      (failure) => Left(failure),
      (productModels) {
        // Convierte la lista de ProductModel a Product (entidad)
        List<Product> products =
            productModels.map((model) => model.toEntity()).toList();
        // print(products);
        return Right(products);
      },
    );
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      int id, Product product) async {
    final response = await apiClient.updateItem(
      ApiEndpoints.productById(id),
      productModelToJson(
          product), // Convierte Product (entidad) a ProductModel y luego a JSON
      (data) => ProductModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (productModel) {
        // Convierte ProductModel a Product (entidad)
        return Right(productModel.toEntity());
      },
    );
  }
}
