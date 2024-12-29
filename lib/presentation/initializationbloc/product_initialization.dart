import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/product_repository_impl.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/create_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/delete_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_products.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/update_product.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';
// Ensure this import is present

ProductBloc initializeProductBloc() {
  int titleWidth = 16; // Default width
  int priceWidth = 8; // Default width
  int imageWidth = 16; // Default width
  int categoryWidth = 16; // Default width

  final productRepository = ProductRepositoryImpl(apiClient: ApiClient());
  final getProduct = GetProduct(productRepository);
  final getProducts = GetProducts(productRepository);
  final createProduct = CreateProduct(productRepository);
  final deleteProduct = DeleteProduct(productRepository);
  final updateProduct = UpdateProduct(productRepository, getProduct);
  final productBloc = ProductBloc(
      getProduct, getProducts, createProduct, deleteProduct, updateProduct);

  String formatProductRow(product, int titleWidth, int priceWidth,
      int imageWidth, int categoryWidth) {
    return '| ${product.id.toString().padRight(8)} | ${product.title.padRight(titleWidth)} | ${product.price.toString().padRight(priceWidth)} | ${product.image.padRight(imageWidth)} | ${product.category.toString().padRight(categoryWidth)} |';
  }

  void updateWidths(product) {
    titleWidth =
        product.title.length > titleWidth ? product.title.length : titleWidth;
    priceWidth = product.price.toString().length > priceWidth
        ? product.price.toString().length
        : priceWidth;
    imageWidth =
        product.image.length > imageWidth ? product.image.length : imageWidth;
    categoryWidth = product.category.toString().length > categoryWidth
        ? product.category.toString().length
        : categoryWidth;
  }

  void printProductState(String stateName, product) {
    print(
        '$stateName:\n| ID       | Title${' ' * (titleWidth - 5)} | Price${' ' * (priceWidth - 5)} | Image${' ' * (imageWidth - 5)} | Category${' ' * (categoryWidth - 8)} |\n${formatProductRow(product, titleWidth, priceWidth, imageWidth, categoryWidth)}');
  }

  productBloc.state.listen((state) {
    if (state is ProductLoading) {
      print('Loading product...');
    } else if (state is ProductsLoaded) {
      titleWidth = state.products
          .map((p) => p.title.length)
          .reduce((a, b) => a > b ? a : b);
      priceWidth = state.products
          .map((p) => p.price.toString().length)
          .reduce((a, b) => a > b ? a : b);
      imageWidth = state.products
          .map((p) => p.image.length)
          .reduce((a, b) => a > b ? a : b);
      categoryWidth = state.products
          .map((p) => p.category.toString().length)
          .reduce((a, b) => a > b ? a : b);
      print(
          'Products loaded:\n| ID       | Title${' ' * (titleWidth - 5)} | Price${' ' * (priceWidth - 5)} | Image${' ' * (imageWidth - 5)} | Category${' ' * (categoryWidth - 8)} |\n${state.products.map((p) => formatProductRow(p, titleWidth, priceWidth, imageWidth, categoryWidth)).join('\n')}');
    } else if (state is ProductLoaded) {
      updateWidths(state.product);
      printProductState('Product loaded', state.product);
    } else if (state is ProductCreated) {
      updateWidths(state.product);
      printProductState('Product created', state.product);
    } else if (state is ProductDeleted) {
      updateWidths(state.product);
      printProductState('Product deleted with ID', state.product);
    } else if (state is ProductUpdated) {
      updateWidths(state.product);
      printProductState('Product updated', state.product);
    } else if (state is ProductError) {
      print('Error: ${state.message}');
    }
  });

  return productBloc;
}
