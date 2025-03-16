import 'dart:convert';

import '../../../../core/models/base_model.dart';
import '../../domain/entities/client_order.dart';

class ClientOrderModel extends BaseModel<ClientOrder> {
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime sendDate;
  final String address;
  final String rt;
  final String rw;
  final String detailAddress;

  ClientOrderModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.sendDate,
    required this.address,
    required this.rt,
    required this.rw,
    required this.detailAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'name': name,
      'phone_number': phoneNumber,
      'order_send_date': sendDate.toIso8601String(),
      'address': address,
      'rt': rt,
      'rw': rw,
      'detail_address': detailAddress,
    };
  }

  factory ClientOrderModel.fromMap(Map<String, dynamic> map) {
    return ClientOrderModel(
      id: map['ID'] as String,
      name: map['name'] as String,
      phoneNumber: map['phone_number'] as String,
      sendDate: DateTime.parse(map['send_date']),
      address: map['address'] as String,
      rt: map['rt'] as String,
      rw: map['rw'] as String,
      detailAddress: map['detail_address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientOrderModel.fromJson(String source) =>
      ClientOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  ClientOrder toEntity() {
    return ClientOrder(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      sendDate: sendDate,
      address: address,
      rt: rt,
      rw: rw,
      detailAddress: detailAddress,
    );
  }
}
