import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/cart_repository_impl.dart';
import 'package:fase2cleanarchitecture/data/repositories/product_repository_impl.dart';
import 'package:fase2cleanarchitecture/data/repositories/user_repository_impl.dart';
import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/create_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/delete_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/update_cart.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/create_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/delete_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/get_products.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/products/update_product.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/carts/get_carts.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/create_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/delete_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/get_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/get_users.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/update_user.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/cart_bloc.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/user_bloc.dart';

void main() {
  final productRepository = ProductRepositoryImpl(apiClient: ApiClient());
  final getProduct = GetProduct(productRepository);
  final getProducts = GetProducts(productRepository);
  final createProduct = CreateProduct(productRepository);
  final deleteProduct = DeleteProduct(productRepository);
  final updateProduct = UpdateProduct(productRepository, getProduct);
  final productBloc = ProductBloc(
      getProduct, getProducts, createProduct, deleteProduct, updateProduct);

  final cartRepository = CartRepositoryImpl(apiClient: ApiClient());
  final getCarts = GetCarts(cartRepository);
  final getcarts = GetCarts(cartRepository);
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

  final userRepository = UserRepositoryImpl(apiClient: ApiClient());
  final getUsers = GetUsers(userRepository);
  final getUser = GetUser(userRepository);
  final deleteUser = DeleteUser(userRepository);
  final createUser = CreateUser(userRepository);
  final updateUser = UpdateUser(userRepository, getUser);

  final userBloc =
      UserBloc(getUsers, getUser, deleteUser, createUser, updateUser);

  userBloc.state.listen((state) {
    if (state is UserLoading) {
      print('Loading users...');
    } else if (state is UsersLoaded) {
      print('Users loaded: ${state.users.length}');
    } else if (state is UserLoaded) {
      print('User loaded: ${state.user.id} ');
    } else if (state is UserDeleted) {
      print('User deleted with ID: ${state.user.id}');
    } else if (state is UserCreated) {
      print('User created: ${state.user.id}');
    } else if (state is UserUpdated) {
      print('User updated: ${state.user.id}');
    } else if (state is UserError) {
      print('Error: ${state.message}');
    }
  });

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
  //productBloc.eventSink.add(UpdateProductEvent(1));
  //cartBloc.eventSink.add(LoadCartsEvent());
  //cartBloc.eventSink.add(LoadCartEvent(1));
  //cartBloc.eventSink.add(DeleteCartEvent(1));
  cartBloc.eventSink.add(CreateCartEvent(Cart(
    id: 0,
    userId: 1,
    date: DateTime.now(),
    products: [
      Products(productId: 1, quantity: 2),
      Products(productId: 2, quantity: 1),
    ],
  )));
  //cartBloc.eventSink.add(UpdateCartEvent(1));

  //userBloc.eventSink.add(LoadUsersEvent());
  //userBloc.eventSink.add(LoadUserEvent(1));
  //userBloc.eventSink.add(DeleteUserEvent(1));
  // userBloc.eventSink.add(CreateUserEvent(User(
  //   id: 0,
  //   username: 'test',
  //   password: 'test',
  //   phone: '1234567890',

  //   name: Name(firstname: 'John', lastname: 'Doe'),
  //   email: 'john.doe@example.com',
  //   // other user properties
  // )));
  // userBloc.eventSink.add(UpdateUserEvent(1));
}
