import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/data_sources/api_endpoints.dart';
import 'package:fase2cleanarchitecture/data/mappers/user_mapper.dart';
import 'package:fase2cleanarchitecture/data/models/user/address_model.dart';
import 'package:fase2cleanarchitecture/data/models/user/geolocation_model.dart';
import 'package:fase2cleanarchitecture/data/models/user/name_model.dart';
import 'package:fase2cleanarchitecture/data/models/user/user_model.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'package:fase2cleanarchitecture/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<User>>> fetchUsers() async {
    final response = await apiClient.fetchList(
      ApiEndpoints.users,
      (data) => UserModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (userModels) {
        List<User> users =
            userModels.map((model) => UserMapper.toEntity(model)).toList();
        return Right(users);
      },
    );
  }

  @override
  Future<Either<Failure, User>> fetchUserById(int id) async {
    final response = await apiClient.fetchItem(
      ApiEndpoints.userById(id),
      (data) => UserModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(UserMapper.toEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    final response = await apiClient.createItem(
      ApiEndpoints.users,
      createUserModel(user).toJson(),
      (data) => UserModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(UserMapper.toEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, User>> updateUser(int id, User user) async {
    final response = await apiClient.updateItem(
      ApiEndpoints.userById(id),
      createUserModel(user).toJson(),
      (data) => UserModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(UserMapper.toEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, User>> deleteUser(int id) async {
    final response = await apiClient.deleteItem(
      ApiEndpoints.userById(id),
      (data) => UserModel.fromJson(data),
    );

    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(UserMapper.toEntity(userModel)),
    );
  }

  UserModel createUserModel(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      password: user.password,
      name: NameModel(
        firstname: user.name?.firstname ?? '',
        lastname: user.name?.lastname ?? '',
      ),
      phone: user.phone,
      address: AddressModel(
        geolocation: GeolocationModel(
          lat: user.address?.geolocation.lat ?? '',
          long: user.address?.geolocation.long ?? '',
        ),
        city: user.address?.city ?? '',
        street: user.address?.street ?? '',
        number: user.address?.number ?? 0,
        zipcode: user.address?.zipcode ?? '',
      ),
    );
  }
}
