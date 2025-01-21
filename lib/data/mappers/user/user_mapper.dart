import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import '../../models/user/user_model.dart';
import 'address_mapper.dart';
import 'name_mapper.dart';

class UserMapper {
  static User toEntity(UserModel model) {
    return User(
      id: model.id,
      email: model.email,
      username: model.username,
      password: model.password,
      name: NameMapper.toEntity(model.name!),
      phone: model.phone,
      address:
          model.address != null ? AddressMapper.toEntity(model.address!) : null,
    );
  }

  static UserModel toModel(User entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      name: NameMapper.toModel(entity.name),
      phone: entity.phone,
      address: entity.address != null
          ? AddressMapper.toModel(entity.address!)
          : null,
    );
  }

  static Map<String, dynamic> toJson(User entity) {
    return {
      'id': entity.id,
      'email': entity.email,
      'username': entity.username,
      'password': entity.password,
      'name': NameMapper.toJson(entity.name),
      'phone': entity.phone,
      'address':
          entity.address != null ? AddressMapper.toJson(entity.address!) : null,
    };
  }
}
