import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> fetchUsers();
  Future<Either<Failure, User>> fetchUserById(int id);
  Future<Either<Failure, User>> createUser(User user);
  Future<Either<Failure, User>> updateUser(int id, User user);
  Future<Either<Failure, User>> deleteUser(int id);
}
