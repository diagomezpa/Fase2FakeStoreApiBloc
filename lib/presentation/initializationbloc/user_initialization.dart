import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/user_repository_impl.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/user_bloc.dart';

import '../../domain/use_cases/users/create_user.dart';
import '../../domain/use_cases/users/delete_user.dart';
import '../../domain/use_cases/users/get_user.dart';
import '../../domain/use_cases/users/get_users.dart';
import '../../domain/use_cases/users/update_user.dart';

UserBloc initializeUserBloc() {
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

  return userBloc;
}
