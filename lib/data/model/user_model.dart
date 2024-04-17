// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final String city;
  final String id;
  UserModel({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.id,
  });

  UserModel copyWith({
    String? name,
    String? address,
    String? email,
    String? phoneNumber,
    String? city,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      city: map['city'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, address: $address, email: $email, phoneNumber: $phoneNumber, city: $city, id: $id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.city == city &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        city.hashCode ^
        id.hashCode;
  }
}
