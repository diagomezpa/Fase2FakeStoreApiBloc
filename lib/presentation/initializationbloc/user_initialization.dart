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
      print(
          'Users loaded:\n${state.users.map((u) => 'id ${u.id} email ${u.email} username ${u.username} name ${u.name.firstname} ${u.name.lastname} phone ${u.phone} address: ${u.address?.street} ${u.address?.city} ${u.address?.zipcode}').join('\n')}');
    } else if (state is UserLoaded) {
      print(
          'User loaded: id ${state.user.id} email ${state.user.email} username ${state.user.username} name ${state.user.name.firstname} ${state.user.name.lastname} phone ${state.user.phone} address: ${state.user.address?.street} ${state.user.address?.city} ${state.user.address?.zipcode}');
    } else if (state is UserDeleted) {
      print(
          'User deleted with ID: id ${state.user.id} email ${state.user.email} username ${state.user.username} name ${state.user.name.firstname} ${state.user.name.lastname} phone ${state.user.phone} address: ${state.user.address?.street} ${state.user.address?.city} ${state.user.address?.zipcode}');
    } else if (state is UserCreated) {
      print(
          'User created: id ${state.user.id} email ${state.user.email} username ${state.user.username} name ${state.user.name.firstname} ${state.user.name.lastname} phone ${state.user.phone} address: ${state.user.address?.street} ${state.user.address?.city} ${state.user.address?.zipcode}');
    } else if (state is UserUpdated) {
      print(
          'User updated: id ${state.user.id} email ${state.user.email} username ${state.user.username} name ${state.user.name.firstname} ${state.user.name.lastname} phone ${state.user.phone} address: ${state.user.address?.street} ${state.user.address?.city} ${state.user.address?.zipcode}');
    } else if (state is UserError) {
      print('Error: ${state.message}');
    }
  });

  return userBloc;
}
