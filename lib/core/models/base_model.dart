abstract class BaseModel<E> {
  E toEntity();

  static double parsePriceToDouble(Map<String, dynamic> map) {
    var price = map["price"] ?? 0.0;

    if (price is! double && price != null) {
      price = price.toDouble();
    } else {
      price = price;
    }

    return price;
  }
}
