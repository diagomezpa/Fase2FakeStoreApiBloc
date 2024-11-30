// Definir eventos
import 'dart:async';

import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_products.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/create_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/delete_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/update_product.dart';

abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final int id;
  LoadProduct(this.id);
}

class LoadProducts extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent {
  final int id;
  DeleteProductEvent(this.id);
}

class UpdateProductEvent extends ProductEvent {
  final int id;
  UpdateProductEvent(this.id);
}

// Definir estados
abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;
  ProductLoaded(this.product);
}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductCreated extends ProductState {
  final Product product;
  ProductCreated(this.product);
}

class ProductDeleted extends ProductState {
  final Product product;
  ProductDeleted(this.product);
}

class ProductUpdated extends ProductState {
  final Product product;
  ProductUpdated(this.product);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// creando el la clase ProductBloc
// Crear la clase BLoC
class ProductBloc {
  final GetProduct getProduct;
  final GetProducts getProducts;
  final CreateProduct createProduct;
  final DeleteProduct deleteProduct;
  final UpdateProduct updateProduct;

  final _stateController = StreamController<ProductState>();
  Stream<ProductState> get state => _stateController.stream;

  final _eventController = StreamController<ProductEvent>();
  Sink<ProductEvent> get eventSink => _eventController.sink;

  ProductBloc(this.getProduct, this.getProducts, this.createProduct,
      this.deleteProduct, this.updateProduct) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ProductEvent event) async {
    if (event is LoadProduct) {
      _stateController.add(ProductLoading());
      final failureOrProduct = await getProduct(event.id);
      failureOrProduct.fold(
        (failure) =>
            _stateController.add(ProductError(_mapFailureToMessage(failure))),
        (product) => _stateController.add(ProductLoaded(product)),
      );
    }
    if (event is LoadProducts) {
      _stateController.add(ProductLoading());
      final failureOrProducts = await getProducts();

      failureOrProducts.fold(
        (failure) =>
            _stateController.add(ProductError(_mapFailureToMessage(failure))),
        (products) => _stateController.add(ProductsLoaded(products)),
      );
    }
    if (event is CreateProductEvent) {
      _stateController.add(ProductLoading());
      final failureOrProduct = await createProduct(event.product);
      failureOrProduct.fold(
        (failure) =>
            _stateController.add(ProductError(_mapFailureToMessage(failure))),
        (product) => _stateController.add(ProductCreated(product)),
      );
    }
    if (event is DeleteProductEvent) {
      _stateController.add(ProductLoading());
      final failureOrSuccess = await deleteProduct(event.id);
      failureOrSuccess.fold(
        (failure) =>
            _stateController.add(ProductError(_mapFailureToMessage(failure))),
        (product) => _stateController.add(
            ProductDeleted(product)), // or another state indicating success
      );
    }
    if (event is UpdateProductEvent) {
      _stateController.add(ProductLoading());
      final failureOrProduct = await updateProduct(event.id);
      failureOrProduct.fold(
        (failure) =>
            _stateController.add(ProductError(_mapFailureToMessage(failure))),
        (product) => _stateController.add(ProductUpdated(product)),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Puedes personalizar los mensajes de error según el tipo de Failure
    return 'Error al cargar el producto';
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
