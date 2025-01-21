import 'package:fase2cleanarchitecture/data/models/user/address_model.dart';
import '../../../domain/entities/user.dart';
import 'geolocation_mapper.dart';

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
