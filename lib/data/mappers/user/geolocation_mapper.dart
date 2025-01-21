import 'package:fase2cleanarchitecture/data/models/user/geolocation_model.dart';

import '../../../domain/entities/user.dart';

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
