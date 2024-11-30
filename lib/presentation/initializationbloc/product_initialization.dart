import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/product_repository_impl.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/create_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/delete_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_products.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/update_product.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';

ProductBloc initializeProductBloc() {
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
      print(
          'Product loaded: ${state.product.id} ${state.product.title} ${state.product.price} ${state.product.image} ${state.product.category} ');
    } else if (state is ProductsLoaded) {
      print(
          'Products loaded:\n${state.products.map((p) => '{${p.id}} ${p.title} ${p.price} ${p.image} ${p.category}').join('\n')}');
    } else if (state is ProductCreated) {
      print(
          'Product created: ${state.product.id} ${state.product.title} ${state.product.price} ${state.product.image} ${state.product.category} ');
    } else if (state is ProductDeleted) {
      print(
          'Product deleted with ID: ${state.product.id} ${state.product.title} ${state.product.price} ${state.product.image} ${state.product.category}');
    } else if (state is ProductUpdated) {
      print(
          'Product updated: ${state.product.id} ${state.product.title} ${state.product.price} ${state.product.image} ${state.product.category}');
    } else if (state is ProductError) {
      print('Error: ${state.message}');
    }
  });

  return productBloc;
}
