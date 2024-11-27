import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/product_repository_impl.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/create_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/delete_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_products.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/update_product.dart';

void main() {
  final productRepository = ProductRepositoryImpl(apiClient: ApiClient());
  final getProduct = GetProduct(productRepository);
  final getProducts = GetProducts(productRepository);
  final createProduct = CreateProduct(productRepository);
  final deleteProduct = DeleteProduct(productRepository);
  final updateProduct = UpdateProduct(productRepository, getProduct);
  final productBloc = ProductBloc(
      getProduct, getProducts, createProduct, deleteProduct, updateProduct);

  productBloc.state.listen((state) {
    if (state is ProductLoading) {
      print('Loading product...');
    } else if (state is ProductLoaded) {
      print('Product loaded: ${state.product.title}');
    } else if (state is ProductsLoaded) {
      print(
          'Products loaded: ${state.products.map((p) => p.title).join(', ')}');
    } else if (state is ProductCreated) {
      print('Product created: ${state.product.title}');
    } else if (state is ProductDeleted) {
      print('Product deleted with ID: ${state.product.id}');
    } else if (state is ProductUpdated) {
      print('Product updated: ${state.product.title}');
    } else if (state is ProductError) {
      print('Error: ${state.message}');
    }
  });

  // Crear una categoría

  //productBloc.eventSink.add(LoadProduct(1));
  //productBloc.eventSink.add(LoadProducts());
  //productBloc.eventSink.add(DeleteProductEvent(4));
  // productBloc.eventSink.add(CreateProductEvent(Product(
  //   id: 0,
  //   title: 'Product 1',
  //   description: 'Description 1',
  //   category: Category.ELECTRONICS,
  //   image: 'https://example.com/smartphone.jpg',
  //   rating: Rating(rate: 4.5, count: 150),
  //   price: 101,
  // )));
  productBloc.eventSink.add(UpdateProductEvent(1));
}
