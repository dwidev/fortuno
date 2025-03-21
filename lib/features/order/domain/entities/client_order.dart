import 'package:equatable/equatable.dart';
import 'package:fortuno/core/core.dart';

import '../../../../core/utils/formatter.dart';

class ClientOrder extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime sendDate;
  final String address;
  final String rt;
  final String rw;
  final String detailAddress;

  String get sendDateDisplay => formatToDateTime(sendDate);

  const ClientOrder({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.sendDate,
    required this.address,
    required this.rt,
    required this.rw,
    required this.detailAddress,
  });

  String get addressDisplay {
    var address = '';
    address += this.address;
    if (rt.isNotEmpty) address += ', RT $rt';
    if (rt.isNotEmpty) address += ', RW $rt';
    address += " ($detailAddress)";
    return address;
  }

  factory ClientOrder.init() => ClientOrder(
    id: '',
    name: '',
    phoneNumber: '',
    sendDate: DateTime.now(),
    address: '',
    rt: '',
    rw: '',
    detailAddress: '',
  );

  @override
  List<Object> get props {
    return [name, phoneNumber, sendDate, address, rt, rw, detailAddress];
  }

  ClientOrder copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    DateTime? sendDate,
    String? address,
    String? rt,
    String? rw,
    String? detailAddress,
  }) {
    return ClientOrder(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sendDate: sendDate ?? this.sendDate,
      address: address ?? this.address,
      rt: rt ?? this.rt,
      rw: rw ?? this.rw,
      detailAddress: detailAddress ?? this.detailAddress,
    );
  }

  @override
  bool get stringify => true;
}
