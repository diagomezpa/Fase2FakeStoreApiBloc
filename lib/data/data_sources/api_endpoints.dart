// api_endpoints.dart

class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://fakestoreapi.com';

  // Productos
  static const String products = '/products';
  static String productById(int id) => '/products/$id';

  // Carritos
  static const String carts = '/carts';
  static String cartById(int id) => '/carts/$id';

  // Usuarios
  static const String users = '/users';
  static String userById(int id) => '/users/$id';
}
