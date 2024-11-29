import 'dart:async';

import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_carts.dart';

// Definir eventos
abstract class CartEvent {}

class LoadCarts extends CartEvent {}

// Definir estados
abstract class CartState {}

class CartLoading extends CartState {}

class CartsLoaded extends CartState {
  final List<Cart> carts;
  CartsLoaded(this.carts);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

// Crear la clase BLoC
class CartBloc {
  final GetCarts getCart;

  final _stateController = StreamController<CartState>();
  Stream<CartState> get state => _stateController.stream;

  final _eventController = StreamController<CartEvent>();
  Sink<CartEvent> get eventSink => _eventController.sink;

  CartBloc(this.getCart) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartEvent event) async {
    if (event is LoadCarts) {
      _stateController.add(CartLoading());
      final failureOrCart = await getCart();
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartsLoaded(cart)),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Puedes personalizar los mensajes de error según el tipo de Failure
    return 'Error al cargar el carrito';
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
