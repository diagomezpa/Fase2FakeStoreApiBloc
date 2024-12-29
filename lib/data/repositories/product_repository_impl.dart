import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_endpoints.dart';
import 'package:fase2cleanarchitecture/data/mappers/product_mapper.dart';
import 'package:fase2cleanarchitecture/data/models/product/product_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;

  ProductRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    final response = await apiClient.createItem(
      ApiEndpoints.products,
      ProductMapper.toJson(product), // Use ProductMapper to convert to JSON
      (data) => ProductModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (productModel) {
        return Right(ProductMapper.toEntity(
            productModel)); // Use ProductMapper to convert to entity
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
      (productModel) => Right(ProductMapper.toEntity(
          productModel)), // Use ProductMapper to convert to entity
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
        return Right(ProductMapper.toEntity(
            productModel)); // Use ProductMapper to convert to entity
      },
    );
  }

  @override
  Future<Either<Failure, List<Product>>> fetchProducts() async {
    final response = await apiClient.fetchList(
      ApiEndpoints.products,
      (data) => ProductModel.fromJson(data), // Convierte a ProductModel
    );

    return response.fold(
      (failure) => Left(failure),
      (productModels) {
        List<Product> products = productModels
            .map((model) => ProductMapper.toEntity(model))
            .toList(); // Use ProductMapper to convert to entity

        return Right(products);
      },
    );
  }

  @override
  Future<Either<Failure, Product>> updateProduct(
      int id, Product product) async {
    final response = await apiClient.updateItem(
      ApiEndpoints.productById(id),
      ProductMapper.toJson(product), // Use ProductMapper to convert to JSON
      (data) => ProductModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (productModel) {
        return Right(ProductMapper.toEntity(
            productModel)); // Use ProductMapper to convert to entity
      },
    );
  }
}
