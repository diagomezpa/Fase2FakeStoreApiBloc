import 'dart:io';

import 'package:fase2cleanarchitecture/domain/entities/cart.dart';
import 'package:fase2cleanarchitecture/domain/entities/product.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/cart_bloc.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/product_bloc.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/user_bloc.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/cart_ser_initialization.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/product_initialization.dart';
import 'package:fase2cleanarchitecture/presentation/initializationbloc/user_initialization.dart';

void main() {
  final productBloc = initializeProductBloc();
  final cartBloc = initializeCartBloc();
  final userBloc = initializeUserBloc();

  print('Seleccione una opción:');
  print('1. Cargar Producto');
  print('2. Cargar Productos');
  print('3. Eliminar Producto');
  print('4. Crear Producto');
  print('5. Cargar Carritos');
  print('6. Cargar Carrito');
  print('7. Eliminar Carrito');
  print('8. Crear Carrito');
  print('9. Actualizar Carrito');
  print('10. Cargar Usuarios');
  print('11. Cargar Usuario');
  print('12. Eliminar Usuario');
  print('13. Crear Usuario');
  print('14. Actualizar Usuario');
  print('15. Salir');

  String? choice = stdin.readLineSync();

  switch (choice) {
    case '1':
      print('Cargando producto...');
      productBloc.eventSink.add(LoadProduct(1));
      break;
    case '2':
      productBloc.eventSink.add(LoadProducts());
      break;
    case '3':
      productBloc.eventSink.add(DeleteProductEvent(4));
      break;
    case '4':
      print('Creando producto...');
      productBloc.eventSink.add(CreateProductEvent(Product(
        id: 0,
        title: 'platos',
        description: 'Description 1',
        category: Category.ELECTRONICS,
        image: 'https://example.com/smartphone.jpg',
        rating: Rating(rate: 4.5, count: 150),
        price: 101,
      )));
      break;
    case '5':
      cartBloc.eventSink.add(LoadCartsEvent());
      break;
    case '6':
      cartBloc.eventSink.add(LoadCartEvent(1));
      break;
    case '7':
      cartBloc.eventSink.add(DeleteCartEvent(1));
      break;
    case '8':
      cartBloc.eventSink.add(CreateCartEvent(Cart(
        id: 0,
        userId: 1,
        date: DateTime.now(),
        products: [
          Products(productId: 1, quantity: 2),
          Products(productId: 2, quantity: 1),
        ],
      )));
      break;
    case '9':
      cartBloc.eventSink.add(UpdateCartEvent(1));
      break;
    case '10':
      userBloc.eventSink.add(LoadUsersEvent());
      break;
    case '11':
      userBloc.eventSink.add(LoadUserEvent(1));
      break;
    case '12':
      userBloc.eventSink.add(DeleteUserEvent(1));
      break;
    case '13':
      userBloc.eventSink.add(CreateUserEvent(User(
        id: 0,
        username: 'test',
        password: 'test',
        phone: '1234567890',
        name: Name(firstname: 'John', lastname: 'Doe'),
        email: 'john.doe@example.com',
      )));
      break;
    case '14':
      userBloc.eventSink.add(UpdateUserEvent(1));
      break;
    case '15':
      exit(0);
    default:
      print('Opción no válida.');
  }
}
