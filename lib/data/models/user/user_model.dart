import 'package:fase2cleanarchitecture/domain/entities/user.dart';
import 'address_model.dart';
import 'name_model.dart';

class UserModel {
  final int? id;
  final String? email;
  final String? username;
  final String? password;
  final NameModel? name;
  final String? phone;
  final AddressModel? address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      name: NameModel.fromJson(json['name']),
      phone: json['phone'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'name': name?.toJson(),
      'phone': phone,
      'address': address?.toJson(),
    };
  }
}
