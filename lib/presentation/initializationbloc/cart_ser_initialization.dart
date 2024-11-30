import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/create_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/delete_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_carts.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/update_cart.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/cart_bloc.dart';
import 'package:fase2cleanarchitecture/data/repositories/cart_repository_impl.dart';

CartBloc initializeCartBloc() {
  final cartRepository = CartRepositoryImpl(apiClient: ApiClient());
  final getCarts = GetCarts(cartRepository);
  final getCart = GetCart(cartRepository);
  final deleteCart = DeleteCart(cartRepository);
  final createCart = CreateCart(cartRepository);
  final updateCart = UpdateCart(cartRepository, getCart);

  final cartBloc =
      CartBloc(getCarts, getCart, deleteCart, createCart, updateCart);

  cartBloc.state.listen((state) {
    if (state is CartLoading) {
      print('Loading carts...');
    } else if (state is CartLoaded) {
      print('Cart loaded: ${state.cart.id} ${state.cart.userId}');
    } else if (state is CartsLoaded) {
      print('Carts loaded: ${state.carts.length}');
    } else if (state is CartDeleted) {
      print('Cart deleted with ID: ${state.cart.id}');
    } else if (state is CartCreated) {
      print('Cart created: ${state.cart.id}');
    } else if (state is CartUpdated) {
      print('Cart updated: ${state.cart.id}');
    } else if (state is CartError) {
      print('Error: ${state.message}');
    }
  });

  return cartBloc;
}
