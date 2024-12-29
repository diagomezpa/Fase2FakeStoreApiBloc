import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/create_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/delete_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_carts.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/update_cart.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/cart_bloc.dart';
import 'package:fase2cleanarchitecture/data/repositories/cart_repository_impl.dart';

CartBloc initializeCartBloc() {
  int userIdWidth = 8;
  int dateWidth = 8;
  int productsWidth = 8;
  final cartRepository = CartRepositoryImpl(apiClient: ApiClient());
  final getCarts = GetCarts(cartRepository);
  final getCart = GetCart(cartRepository);
  final deleteCart = DeleteCart(cartRepository);
  final createCart = CreateCart(cartRepository);
  final updateCart = UpdateCart(cartRepository, getCart);

  void updateWidths(cart) {
    userIdWidth = cart.userId.toString().length > userIdWidth
        ? cart.userId.toString().length
        : userIdWidth;
    dateWidth = cart.date.toString().length > dateWidth
        ? cart.date.toString().length
        : dateWidth;
    productsWidth = cart.products
        .map((p) => p.productId.toString().length)
        .reduce((a, b) => a > b ? a : b);
  }

  void printCartState(String stateName, cart) {
    print(
        '$stateName:\n| ID       | User ID${' ' * (userIdWidth - 7)} | Date${' ' * (dateWidth - 4)} | Products${' ' * (productsWidth - 8)} |\n| ${cart.id.toString().padRight(8)} | ${cart.userId.toString().padRight(userIdWidth)} | ${cart.date.toString().padRight(dateWidth)} | ${cart.products?.map((p) => '{ productId: ${p.productId} quantity : ${p.quantity}}').join(', ').padRight(productsWidth)} |');
  }

  final cartBloc =
      CartBloc(getCarts, getCart, deleteCart, createCart, updateCart);

  cartBloc.state.listen((state) {
    if (state is CartLoading) {
      print('Loading carts...');
    } else if (state is CartLoaded) {
      updateWidths(state.cart);
      printCartState('Cart loaded', state.cart);
    } else if (state is CartsLoaded) {
      userIdWidth = state.carts
          .map((c) => c.userId.toString().length)
          .reduce((a, b) => a > b ? a : b);
      dateWidth = state.carts
          .map((c) => c.date.toString().length)
          .reduce((a, b) => a > b ? a : b);
      productsWidth = state.carts
          .map((c) => c.products != null
              ? c.products!
                  .map((p) => p.productId.toString().length)
                  .reduce((a, b) => a > b ? a : b)
              : 0)
          .reduce((a, b) => a > b ? a : b);
      print(
          'Carts loaded:\n| ID       | User ID${' '} | Date${' ' * (dateWidth - 4)} | Products${' ' * (productsWidth - 8)} |\n${state.carts.map((c) => '| ${c.id.toString().padRight(8)} | ${c.userId.toString().padRight(userIdWidth)}        | ${c.date.toString().padRight(dateWidth)} | ${c.products?.map((p) => '{ productId: ${p.productId} quantity : ${p.quantity}}').join(', ').padRight(productsWidth)} |').join('\n')}');
    } else if (state is CartDeleted) {
      updateWidths(state.cart);
      printCartState('Cart deleted', state.cart);
    } else if (state is CartCreated) {
      updateWidths(state.cart);
      printCartState('Cart created', state.cart);
    } else if (state is CartUpdated) {
      updateWidths(state.cart);
      printCartState('Cart updated', state.cart);
    } else if (state is CartError) {
      print('Error: ${state.message}');
    }
  });

  return cartBloc;
}
