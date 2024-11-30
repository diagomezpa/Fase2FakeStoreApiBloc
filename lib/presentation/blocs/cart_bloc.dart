import 'dart:async';

import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/create_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/delete_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_carts.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/update_cart.dart';

// Definir eventos
abstract class CartEvent {}

class LoadCartsEvent extends CartEvent {}

class LoadCartEvent extends CartEvent {
  final int id;
  LoadCartEvent(this.id);
}

class DeleteCartEvent extends CartEvent {
  final int id;
  DeleteCartEvent(this.id);
}

class CreateCartEvent extends CartEvent {
  final Cart cart;
  CreateCartEvent(this.cart);
}

class UpdateCartEvent extends CartEvent {
  final int id;
  UpdateCartEvent(this.id);
}

// Definir estados
abstract class CartState {}

class CartLoading extends CartState {}

class CartsLoaded extends CartState {
  final List<Cart> carts;
  CartsLoaded(this.carts);
}

class CartLoaded extends CartState {
  final Cart cart;
  CartLoaded(this.cart);
}

class CartDeleted extends CartState {
  final Cart cart;
  CartDeleted(this.cart);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class CartCreated extends CartState {
  final Cart cart;
  CartCreated(this.cart);
}

class CartUpdated extends CartState {
  final Cart cart;
  CartUpdated(this.cart);
}

// Crear la clase BLoC
class CartBloc {
  final GetCarts getCart;
  final GetCart getCartById;
  final DeleteCart deleteCart;
  final CreateCart createCart;
  final UpdateCart updateCart;

  final _stateController = StreamController<CartState>();
  Stream<CartState> get state => _stateController.stream;

  final _eventController = StreamController<CartEvent>();
  Sink<CartEvent> get eventSink => _eventController.sink;

  CartBloc(this.getCart, this.getCartById, this.deleteCart, this.createCart,
      this.updateCart) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartEvent event) async {
    if (event is LoadCartsEvent) {
      _stateController.add(CartLoading());
      final failureOrCart = await getCart();
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartsLoaded(cart)),
      );
    }
    if (event is LoadCartEvent) {
      _stateController.add(CartLoading());
      final failureOrCart = await getCartById(event.id);
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartLoaded(cart)),
      );
    }

    if (event is DeleteCartEvent) {
      _stateController.add(CartLoading());
      final failureOrCart = await deleteCart(event.id);
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartDeleted(cart)),
      );
    }

    if (event is CreateCartEvent) {
      _stateController.add(CartLoading());
      final failureOrCart = await createCart(event.cart);
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartCreated(cart)),
      );
    }

    if (event is UpdateCartEvent) {
      _stateController.add(CartLoading());
      final failureOrCart = await updateCart(event.id);
      failureOrCart.fold(
        (failure) =>
            _stateController.add(CartError(_mapFailureToMessage(failure))),
        (cart) => _stateController.add(CartUpdated(cart)),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Puedes personalizar los mensajes de error según el tipo de Failure
    return 'Error al cargar el carrito ' + failure.toString();
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
