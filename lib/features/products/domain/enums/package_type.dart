enum PackageType {
  def,
  custom;

  bool get isdef => this == PackageType.def;
  bool get iscustom => this == PackageType.custom;

  String get name => switch (this) {
    PackageType.def => 'default',
    PackageType.custom => 'custom',
  };
}

PackageType packageTypeFromString(String value) => switch (value) {
  'default' => PackageType.def,
  'custom' => PackageType.custom,
  _ => throw UnimplementedError("$value not match with PackageType"),
};

extension BoolPackageTypeEx on bool {
  PackageType get packType => switch (this) {
    true => PackageType.custom,
    _ => PackageType.def,
  };
}
