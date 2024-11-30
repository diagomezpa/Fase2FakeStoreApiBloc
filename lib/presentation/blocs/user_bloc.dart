import 'dart:async';
import 'package:fase2cleanarchitecture/core/error/failures.dart';
import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/create_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/delete_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/get_user.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/get_users.dart';
import 'package:fase2cleanarchitecture/domain/use_cases/users/update_user.dart';

// Definir eventos
abstract class UserEvent {}

class LoadUsersEvent extends UserEvent {}

class LoadUserEvent extends UserEvent {
  final int id;
  LoadUserEvent(this.id);
}

class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(this.id);
}

class CreateUserEvent extends UserEvent {
  final User user;
  CreateUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final int id;
  UpdateUserEvent(this.id);
}

// Definir estados
abstract class UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserDeleted extends UserState {
  final User user;
  UserDeleted(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserCreated extends UserState {
  final User user;
  UserCreated(this.user);
}

class UserUpdated extends UserState {
  final User user;
  UserUpdated(this.user);
}

// Crear la clase BLoC
class UserBloc {
  final GetUsers getUsers;
  final GetUser getUserById;
  final DeleteUser deleteUser;
  final CreateUser createUser;
  final UpdateUser updateUser;

  final _stateController = StreamController<UserState>();
  Stream<UserState> get state => _stateController.stream;

  final _eventController = StreamController<UserEvent>();
  Sink<UserEvent> get eventSink => _eventController.sink;

  UserBloc(this.getUsers, this.getUserById, this.deleteUser, this.createUser,
      this.updateUser) {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(UserEvent event) async {
    if (event is LoadUsersEvent) {
      _stateController.add(UserLoading());
      final failureOrUsers = await getUsers();
      failureOrUsers.fold(
        (failure) =>
            _stateController.add(UserError(_mapFailureToMessage(failure))),
        (users) => _stateController.add(UsersLoaded(users)),
      );
    }
    if (event is LoadUserEvent) {
      _stateController.add(UserLoading());
      final failureOrUser = await getUserById(event.id);
      failureOrUser.fold(
        (failure) =>
            _stateController.add(UserError(_mapFailureToMessage(failure))),
        (user) => _stateController.add(UserLoaded(user)),
      );
    }

    if (event is DeleteUserEvent) {
      _stateController.add(UserLoading());
      final failureOrUser = await deleteUser(event.id);
      failureOrUser.fold(
        (failure) =>
            _stateController.add(UserError(_mapFailureToMessage(failure))),
        (user) => _stateController.add(UserDeleted(user)),
      );
    }

    if (event is CreateUserEvent) {
      _stateController.add(UserLoading());
      final failureOrUser = await createUser(event.user);
      failureOrUser.fold(
        (failure) =>
            _stateController.add(UserError(_mapFailureToMessage(failure))),
        (user) => _stateController.add(UserCreated(user)),
      );
    }

    if (event is UpdateUserEvent) {
      _stateController.add(UserLoading());
      final failureOrUser = await updateUser(event.id);
      failureOrUser.fold(
        (failure) =>
            _stateController.add(UserError(_mapFailureToMessage(failure))),
        (user) => _stateController.add(UserUpdated(user)),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Puedes personalizar los mensajes de error según el tipo de Failure
    return 'Error al cargar el usuario ' + failure.toString();
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
