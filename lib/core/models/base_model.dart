abstract class BaseModel<E> {
  E toEntity();

  static double parseToDouble(num? value) {
    if (value == null) return 0.0;
    if (value is double) return value;

    return double.tryParse("$value") ?? 0.0;
  }
}
