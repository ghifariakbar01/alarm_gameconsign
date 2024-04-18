// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDTO {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final String city;

  UserDTO({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
  });

  UserDTO copyWith({
    String? name,
    String? address,
    String? email,
    String? phoneNumber,
    String? city,
  }) {
    return UserDTO(
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
    };
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      name: map['name'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      city: map['city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDTO.fromJson(String source) =>
      UserDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDTO(name: $name, address: $address, email: $email, phoneNumber: $phoneNumber, city: $city)';
  }

  @override
  bool operator ==(covariant UserDTO other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.city == city;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        city.hashCode;
  }
}
