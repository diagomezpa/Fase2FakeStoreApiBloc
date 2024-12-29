import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import '../../data/models/user_model.dart';

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

class AddressMapper {
  static Address toEntity(AddressModel model) {
    return Address(
      geolocation: GeolocationMapper.toEntity(model.geolocation),
      city: model.city,
      street: model.street,
      number: model.number,
      zipcode: model.zipcode,
    );
  }

  static AddressModel toModel(Address entity) {
    return AddressModel(
      geolocation: GeolocationMapper.toModel(entity.geolocation),
      city: entity.city,
      street: entity.street,
      number: entity.number,
      zipcode: entity.zipcode,
    );
  }

  static Map<String, dynamic> toJson(Address entity) {
    return {
      'geolocation': GeolocationMapper.toJson(entity.geolocation),
      'city': entity.city,
      'street': entity.street,
      'number': entity.number,
      'zipcode': entity.zipcode,
    };
  }
}

class GeolocationMapper {
  static Geolocation toEntity(GeolocationModel model) {
    return Geolocation(
      lat: model.lat,
      long: model.long,
    );
  }

  static GeolocationModel toModel(Geolocation entity) {
    return GeolocationModel(
      lat: entity.lat,
      long: entity.long,
    );
  }

  static Map<String, dynamic> toJson(Geolocation entity) {
    return {
      'lat': entity.lat,
      'long': entity.long,
    };
  }
}

class NameMapper {
  static Name toEntity(NameModel model) {
    return Name(
      firstname: model.firstname,
      lastname: model.lastname,
    );
  }

  static NameModel toModel(Name entity) {
    return NameModel(
      firstname: entity.firstname,
      lastname: entity.lastname,
    );
  }

  static Map<String, dynamic> toJson(Name entity) {
    return {
      'firstname': entity.firstname,
      'lastname': entity.lastname,
    };
  }
}
