
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderModel {
  String id;
  String? uId;
  String? type;
  String fullName;
  String phone;
  String quantity;
  String latitude;
  String longitude;
  Timestamp date;
  String status;
  OrderModel({
    required this.id,
    this.uId,
    this.type,
    required this.fullName,
    required this.phone,
    required this.quantity,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.status,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'uId': uId,
      'type': type,
      'fullName': fullName,
      'phone': phone,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return OrderModel(
      id: id,
      uId: map['uId'] != null ? map['uId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      quantity: map['quantity'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      date: map['date'] as Timestamp,
      status: map['status'] as String,
    );
  }


  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.uId == uId &&
      other.type == type &&
      other.fullName == fullName &&
      other.phone == phone &&
      other.quantity == quantity &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.status == status &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uId.hashCode ^
      type.hashCode ^
      fullName.hashCode ^
      phone.hashCode ^
      quantity.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      status.hashCode ^
      date.hashCode;
  }
  }
