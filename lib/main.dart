import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/cart_ser_initialization.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/product_initialization.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/user_initialization.dart';

void main() {
  final productBloc = initializeProductBloc();
  final cartBloc = initializeCartBloc();
  final userBloc = initializeUserBloc();

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
  // cartBloc.eventSink.add(CreateCartEvent(Cart(
  //   id: 0,
  //   userId: 1,
  //   date: DateTime.now(),
  //   products: [
  //     Products(productId: 1, quantity: 2),
  //     Products(productId: 2, quantity: 1),
  //   ],
  // )));
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
