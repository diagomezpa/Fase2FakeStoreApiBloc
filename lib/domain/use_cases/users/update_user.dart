import 'package:dartz/dartz.dart';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'package:fase2cleanarchitecture/domain/repositories/user_repository.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/get_user.dart';

class UpdateUser {
  final UserRepository repository;
  final GetUser getUser;
  UpdateUser(this.repository, this.getUser);
  Future<Either<Failure, User>> call(int id) {
    final userOrFailure = getUser(id);
    return userOrFailure.then((userOrFailure) async {
      return userOrFailure.fold((failure) => Left(failure), (user) async {
        return await repository.updateUser(id, user);
      });
    });
  }
}
