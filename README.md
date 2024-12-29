# Fase 2 Clean Architecture - Dart

Este proyecto demuestra cómo implementar una arquitectura limpia en una aplicación de línea de comandos. Proporciona ejemplos de manejo de estado reactivo y comunicación efectiva con APIs externas, utilizando **Dart** y herramientas como **dartz** para manejar errores de manera funcional.

La aplicación es un ejemplo de una aplicación de línea de comandos que utiliza Clean Architecture y el patrón BLoC para gestionar el estado de la aplicación. La aplicación interactúa con una API de tienda falsa (FakeStoreApi) para realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en entidades como **User**, **Product** y **Cart**.

## Estructura del Proyecto

La estructura de carpetas sigue los principios de **Clean Architecture**, con las siguientes principales:

```
fase2cleanarchitecture/
├── lib/
│   ├── core/
│   │   └── error/
│   │       └── failures.dart  # Define las clases de error y las fallas comunes
│   ├── data/
│   │   ├── data_sources/
│   │   │   └── api_client.dart  # Cliente para manejar las solicitudes HTTP
│   │   │   └── api_endpoints.dart  # Define los endpoints de la API
│   │   ├── models/
│   │   │   ├── cart/
│   │   │   │   └── cart_model.dart  # Modelo para Cart
│   │   │   │   └── products_model.dart  # Modelo para Products en Cart
│   │   │   ├── product/
│   │   │   │   └── product_model.dart  # Modelo para Product
│   │   │   │   └── rating_model.dart  # Modelo para Rating en Product
│   │   │   │   └── enum_values.dart  # Utilidad para manejar valores de enumeración
│   │   │   └── user/
│   │   │       └── user_model.dart  # Modelo para User
│   │   │       └── name_model.dart  # Modelo para Name en User
│   │   │       └── address_model.dart  # Modelo para Address en User
│   │   │       └── geolocation_model.dart  # Modelo para Geolocation en Address
│   │   ├── mappers/
│   │   │   └── user_mapper.dart  # Mappers para User
│   │   │   └── product_mapper.dart  # Mappers para Product
│   │   │   └── cart_mapper.dart  # Mappers para Cart
│   │   ├── repositories/
│   │       └── user_repository_impl.dart  # Implementación del repositorio para User
│   │       └── product_repository_impl.dart  # Implementación del repositorio para Product
│   │       └── cart_repository_impl.dart  # Implementación del repositorio para Cart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── user.dart  # Entidad para User
│   │   │   └── product.dart  # Entidad para Product
│   │   │   └── cart.dart  # Entidad para Cart
│   ├── repositories/
│   │   └── user_repository.dart  # Interfaz para el repositorio de User
│   │   └── product_repository.dart  # Interfaz para el repositorio de Product
│   │   └── cart_repository.dart  # Interfaz para el repositorio de Cart
│   └── use_cases/
│       └── users/
│           └── get_users.dart  # Caso de uso para obtener los usuarios
│           └── create_user.dart  # Caso de uso para crear un usuario
│           └── delete_user.dart  # Caso de uso para eliminar un usuario
│           └── get_user.dart  # Caso de uso para obtener un usuario por ID
│           └── update_user.dart  # Caso de uso para actualizar un usuario
│       └── products/
│           └── get_products.dart  # Caso de uso para obtener productos
│           └── create_product.dart  # Caso de uso para crear un producto
│           └── delete_product.dart  # Caso de uso para eliminar un producto
│           └── get_product.dart  # Caso de uso para obtener un producto por ID
│           └── update_product.dart  # Caso de uso para actualizar un producto
│       └── carts/
│           └── get_carts.dart  # Caso de uso para obtener el carrito
│           └── create_cart.dart  # Caso de uso para crear un carrito
│           └── remove_from_cart.dart  # Caso de uso para eliminar productos del carrito
│           └── update_cart.dart  # Caso de uso para actualizar el carrito
│   └── presentation/
│       ├── blocs/
│       │   └── user_bloc.dart  # BLoC para manejar el estado de los usuarios
│       │   └── product_bloc.dart  # BLoC para manejar el estado de los productos
│       │   └── cart_bloc.dart  # BLoC para manejar el estado del carrito
│       ├── initializationbloc/
│       │   └── user_initialization.dart  # Inicialización del estado de User
│       │   └── cart_initialization.dart  # Inicialización del estado de Cart
│       │   └── product_initialization.dart  # Inicialización del estado de Product
│       └── main.dart  # Punto de entrada de la aplicación
├── test/
│   └── ...  # falta por implementar
└── README.md  # Documentación de la arquitectura del proyecto

```

## Descripción del Diseño de los Modelos de Datos

### Entidades
Las entidades representan los objetos del dominio y están definidas en el directorio `lib/domain/entities/`. Estas entidades contienen la lógica del negocio principal. Las principales entidades son:

- **User:** Representa a un usuario con atributos como ID, nombre, correo electrónico, etc.
- **Product:** Representa un producto con atributos como ID, nombre, precio, etc.
- **Cart:** Representa un carrito de compras con productos añadidos y su cantidad.

### Modelos
Los modelos están definidos en `lib/data/models/` y se encargan de la serialización/deserialización de datos entre la aplicación y la API. Por ejemplo, `UserModel` es el modelo que convierte datos JSON a la estructura `User` y viceversa.

### Mapeo de Modelos a Entidades
Cada vez que se recibe una respuesta de la API, los modelos se convierten a las entidades correspondientes usando un proceso de mapeo. Esta transformación asegura que las entidades de dominio permanezcan independientes de las implementaciones externas.

## Solicitudes y Procesamiento de la API

El proyecto realiza solicitudes HTTP a la API usando el `ApiClient`. Se definen las siguientes operaciones para cada entidad:

- **Usuarios:** Obtener usuarios, crear, actualizar, eliminar.
- **Productos:** Obtener productos, crear, actualizar, eliminar.
- **Carrito:** Obtener carrito, agregar o eliminar productos del carrito.

Cada repositorio implementa un método correspondiente para interactuar con la API y retorna un resultado utilizando la estructura `Either<Failure, T>` proporcionada por **dartz** para manejar errores y datos de forma funcional.

### Ejemplo de una solicitud para obtener productos:

```dart
final response = await apiClient.fetchList(
  ApiEndpoints.products,
  (data) => ProductModel.fromJson(data),
);
```

## Manejo de Errores con `Either`

Se usa la librería **dartz** para manejar errores de manera funcional. Los resultados de las solicitudes HTTP se envuelven en un tipo `Either<Failure, T>`, donde:

- **Left:** Representa un error de tipo `Failure`.
- **Right:** Representa un valor exitoso de tipo `T` (por ejemplo, una lista de productos o un usuario).

Esto permite que el control de flujo sea claro y que los errores se manejen de manera explícita en lugar de usar excepciones.

Ejemplo:

```dart
final response = await apiClient.fetchItem(
  ApiEndpoints.userById(id),
  (data) => UserModel.fromJson(data),
);

return response.fold(
  (failure) => Left(failure),
  (userModel) => Right(userModel.toEntity()),
);
```

## Lógica en consola

La aplicación depende de la entrada del usuario a través de la consola para realizar las operaciones (como cargar, crear, actualizar o eliminar productos, carritos y usuarios). 

Por ahora, los valores de entrada están **Por consola** en lo facilita que puedan probar con varios datos. **Una mejora futura** será agregar manejo de errores en caso de que el usuario ingrese un valor incorrecto, y ofrecer una interfaz más robusta.

## Funcionalidades

- **Productos**:
  - Cargar productos
  - Crear producto
  - Eliminar producto
  - Obtener producto por ID
  - Actualizar producto

- **Carritos**:
  - Cargar carritos
  - Crear carrito
  - Eliminar carrito
  - Actualizar carrito

- **Usuarios**:
  - Cargar usuarios
  - Crear usuario
  - Eliminar usuario
  - Actualizar usuario

## Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/diagomezpa/Fase2FakeStoreApiBloc.git
   ```

2. Navega al directorio del proyecto:
   ```bash
   cd fase2cleanarchitecture
   ```

3. Instala las dependencias:
   ```bash
   dart pub get
   ```

4. Ve a la carpeta `bin`:
   ```bash
   cd bin
   ```

5. Ejecuta la aplicación:
   ```bash
   dart run fase2cleanarchitecture.dart
   ```
---

Espero que este `README.md` sea útil documente de forma clara y completa.

