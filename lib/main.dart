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
      print('Ingrese el ID del producto a cargar:');
      int? productId = int.tryParse(stdin.readLineSync() ?? '');
      if (productId != null) {
        productBloc.eventSink.add(LoadProduct(productId));
      } else {
        print('ID de producto no válido.');
      }
      break;
    case '2':
      productBloc.eventSink.add(LoadProducts());
      break;
    case '3':
      print('Ingrese el ID del producto a eliminar:');
      int? productId = int.tryParse(stdin.readLineSync() ?? '');
      if (productId != null) {
        productBloc.eventSink.add(DeleteProductEvent(productId));
      } else {
        print('ID de producto no válido.');
      }
      break;
    case '4':
      print('Ingrese el título del producto:');
      String? title = stdin.readLineSync();
      print('Ingrese la descripción del producto:');
      String? description = stdin.readLineSync();
      print('Ingrese la URL de la imagen del producto:');
      String? image = stdin.readLineSync();
      print('Ingrese la calificación del producto:');
      double? rate = double.tryParse(stdin.readLineSync() ?? '');
      print('Ingrese el número de calificaciones del producto:');
      int? count = int.tryParse(stdin.readLineSync() ?? '');
      print('Ingrese el precio del producto:');
      double? price = double.tryParse(stdin.readLineSync() ?? '');

      if (title != null &&
          description != null &&
          image != null &&
          rate != null &&
          count != null &&
          price != null) {
        productBloc.eventSink.add(CreateProductEvent(Product(
          id: 0,
          title: title,
          description: description,
          category: Category.ELECTRONICS,
          image: image,
          rating: Rating(rate: rate, count: count),
          price: price,
        )));
      } else {
        print('Datos del producto no válidos.');
      }
      break;
    case '5':
      cartBloc.eventSink.add(LoadCartsEvent());
      break;
    case '6':
      cartBloc.eventSink.add(LoadCartEvent(1));
      break;
    case '7':
      print('Ingrese el ID del carrito a eliminar:');
      int? cartId = int.tryParse(stdin.readLineSync() ?? '');
      if (cartId != null) {
        cartBloc.eventSink.add(DeleteCartEvent(cartId));
      } else {
        print('ID de carrito no válido.');
      }
      break;
    case '8':
      print('Ingrese el ID del usuario:');
      int? userId = int.tryParse(stdin.readLineSync() ?? '');
      print('Ingrese la fecha (YYYY-MM-DD):');
      DateTime? date = DateTime.tryParse(stdin.readLineSync() ?? '');
      if (userId != null && date != null) {
        cartBloc.eventSink.add(CreateCartEvent(Cart(
          id: 0,
          userId: userId,
          date: date,
          products: [], // You can add logic to input products if needed
        )));
      } else {
        print('Datos del carrito no válidos.');
      }
      break;
    case '9':
      print('Ingrese el ID del carrito a actualizar:');
      int? cartId = int.tryParse(stdin.readLineSync() ?? '');
      if (cartId != null) {
        cartBloc.eventSink.add(UpdateCartEvent(cartId));
      } else {
        print('ID de carrito no válido.');
      }
      break;
    case '10':
      userBloc.eventSink.add(LoadUsersEvent());
      break;
    case '11':
      print('Ingrese el ID del usuario:');
      int? userId = int.tryParse(stdin.readLineSync() ?? '');
      if (userId != null) {
        userBloc.eventSink.add(LoadUserEvent(userId));
      } else {
        print('ID de usuario no válido.');
      }
      break;
    case '12':
      print('Ingrese el ID del usuario a eliminar:');
      int? userId = int.tryParse(stdin.readLineSync() ?? '');
      if (userId != null) {
        userBloc.eventSink.add(DeleteUserEvent(userId));
      } else {
        print('ID de usuario no válido.');
      }
      break;
    case '13':
      print('Ingrese el nombre de usuario:');
      String? username = stdin.readLineSync();
      print('Ingrese la contraseña:');
      String? password = stdin.readLineSync();
      print('Ingrese el teléfono:');
      String? phone = stdin.readLineSync();
      print('Ingrese el nombre:');
      String? firstname = stdin.readLineSync();
      print('Ingrese el apellido:');
      String? lastname = stdin.readLineSync();
      print('Ingrese el correo electrónico:');
      String? email = stdin.readLineSync();

      userBloc.eventSink.add(CreateUserEvent(User(
        id: 0,
        username: username ?? '',
        password: password ?? '',
        phone: phone ?? '',
        name: Name(firstname: firstname ?? '', lastname: lastname ?? ''),
        email: email ?? '',
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
