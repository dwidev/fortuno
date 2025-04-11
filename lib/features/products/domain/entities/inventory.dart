// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/utils/formatter.dart';
import 'image.dart';

abstract class Inventory {
  final String id;
  final String name;
  final String code;
  final double price;
  final ImageData image;

  const Inventory({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.image,
  });
}

extension Ix on Inventory {
  bool get isDefaultName => name.toLowerCase().contains("nama");

  String get kDisplayPrice => "${(price / 1000).toStringAsFixed(0)}K";

  String get priceFormated => moneyFormatter(price);
}
