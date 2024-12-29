import 'package:fase2cleanarchitecture/data/data_sources/api_client.dart';
import 'package:fase2cleanarchitecture/data/repositories/user_repository_impl.dart';
import 'package:fase2cleanarchitecture/presentation/blocs/user_bloc.dart';

import '../../domain/use_cases/users/create_user.dart';
import '../../domain/use_cases/users/delete_user.dart';
import '../../domain/use_cases/users/get_user.dart';
import '../../domain/use_cases/users/get_users.dart';
import '../../domain/use_cases/users/update_user.dart';

UserBloc initializeUserBloc() {
  int emailWidth = 16;
  int usernameWidth = 16;
  int nameWidth = 16;
  int phoneWidth = 16;
  int addressWidth = 16;

  final userRepository = UserRepositoryImpl(apiClient: ApiClient());
  final getUsers = GetUsers(userRepository);
  final getUser = GetUser(userRepository);
  final deleteUser = DeleteUser(userRepository);
  final createUser = CreateUser(userRepository);
  final updateUser = UpdateUser(userRepository, getUser);

  void updateWidths(user) {
    emailWidth =
        user.email.length > emailWidth ? user.email.length : emailWidth;
    usernameWidth = user.username.length > usernameWidth
        ? user.username.length
        : usernameWidth;
    nameWidth =
        (user.name.firstname.length + user.name.lastname.length + 1) > nameWidth
            ? (user.name.firstname.length + user.name.lastname.length + 1)
            : nameWidth;
    phoneWidth =
        user.phone.length > phoneWidth ? user.phone.length : phoneWidth;
    addressWidth = (user.address?.street.length ?? 0) +
                (user.address?.city.length ?? 0) +
                (user.address?.zipcode.length ?? 0) +
                2 >
            addressWidth
        ? (user.address?.street.length ?? 0) +
            (user.address?.city.length ?? 0) +
            (user.address?.zipcode.length ?? 0) +
            2
        : addressWidth;
  }

  String formatUserRow(user) {
    return '| ${user.id.toString().padRight(8)} | ${user.email.padRight(emailWidth)} | ${user.username.padRight(usernameWidth)} | ${user.name.firstname} ${user.name.lastname.padRight(nameWidth - user.name.firstname.length - 1)} | ${user.phone.padRight(phoneWidth)} | ${user.address?.street} ${user.address?.city} ${user.address?.zipcode.padRight(addressWidth - (user.address?.street.length ?? 0) - (user.address?.city.length ?? 0) - 2)} |';
  }

  void printUserState(String stateName, user) {
    print(
        '$stateName:\n| ID       | Email${' ' * (emailWidth - 5)} | Username${' ' * (usernameWidth - 8)} | Name${' ' * (nameWidth - 4)} | Phone${' ' * (phoneWidth - 5)} | Address${' ' * (addressWidth - 7)} |\n${formatUserRow(user)}');
  }

  final userBloc =
      UserBloc(getUsers, getUser, deleteUser, createUser, updateUser);

  userBloc.state.listen((state) {
    if (state is UserLoading) {
      print('Loading users...');
    } else if (state is UsersLoaded) {
      emailWidth = state.users
          .map((u) => u.email?.length ?? 0)
          .reduce((a, b) => a > b ? a : b);
      usernameWidth = state.users
          .map((u) => u.username?.length ?? 0)
          .reduce((a, b) => a > b ? a : b);
      nameWidth = state.users
          .map((u) => u.name.firstname.length + u.name.lastname.length + 1)
          .reduce((a, b) => a > b ? a : b);
      phoneWidth = state.users
          .map((u) => u.phone?.length ?? 0)
          .reduce((a, b) => a > b ? a : b);
      addressWidth = state.users
          .map((u) =>
              (u.address?.street.length ?? 0) +
              (u.address?.city.length ?? 0) +
              (u.address?.zipcode.length ?? 0) +
              2)
          .reduce((a, b) => a > b ? a : b);
      print(
          'Users loaded:\n| ID       | Email${' ' * (emailWidth - 5)} | Username${' ' * (usernameWidth - 8)} | Name${' ' * (nameWidth - 4)} | Phone${' ' * (phoneWidth - 5)} | Address${' ' * (addressWidth - 7)} |\n${state.users.map((u) => formatUserRow(u)).join('\n')}');
    } else if (state is UserLoaded) {
      updateWidths(state.user);
      printUserState('User loaded', state.user);
    } else if (state is UserDeleted) {
      updateWidths(state.user);
      printUserState('User deleted', state.user);
    } else if (state is UserCreated) {
      updateWidths(state.user);
      printUserState('User created', state.user);
    } else if (state is UserUpdated) {
      updateWidths(state.user);
      printUserState('User updated', state.user);
    } else if (state is UserError) {
      print('Error: ${state.message}');
    }
  });

  return userBloc;
}
