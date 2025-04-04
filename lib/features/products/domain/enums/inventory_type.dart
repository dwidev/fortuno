enum InventoryType {
  category,
  product,
  package;

  bool get iscategory => this == InventoryType.category;
  bool get isproduct => this == InventoryType.product;
  bool get ispackage => this == InventoryType.package;

  String get table => switch (this) {
    InventoryType.category => 'category',
    InventoryType.product => 'products',
    InventoryType.package => 'package',
  };
}
