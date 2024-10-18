// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  String? uId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? type;
  @HiveField(5)
  String? tokon;
  UserModel({
    this.uId,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.tokon,
  });

  UserModel copyWith({
    String? uId,
    String? name,
    String? email,
    String? phone,
    String? type,
    String? tokon,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      tokon: tokon ?? this.tokon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'type': type,
      'tokon': tokon,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] != null ? map['uId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      tokon: map['tokon'] != null ? map['tokon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uId: $uId, name: $name, email: $email, phone: $phone, type: $type, tokon: $tokon)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uId == uId &&
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.type == type &&
      other.tokon == tokon;
  }

  @override
  int get hashCode {
    return uId.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      type.hashCode ^
      tokon.hashCode;
  }
}
