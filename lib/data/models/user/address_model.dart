import 'geolocation_model.dart';

class AddressModel {
  final GeolocationModel geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      geolocation: GeolocationModel.fromJson(json['geolocation']),
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geolocation': geolocation.toJson(),
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }
}
