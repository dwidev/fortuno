import 'package:fortuno/features/products/domain/enums/inventory_type.dart';

import '../entities/category.dart';
import '../entities/package.dart';
import '../entities/product.dart';

abstract class ProductsRepository {
  // GET
  Future<List<CategoryProduct>> getCategories({required String companyId});
  Future<List<Product>> getProductByCategory({required String categoryId});
  Future<List<Product>> getProductByCompany({required String companyId});
  Future<List<Package>> getPackageByCategory({required String categoryId});
  Future<List<Package>> getPackageByCompany({required String companyId});

  // INSERT
  Future<CategoryProduct> insertCategory({
    required String companyId,
    required CategoryProduct category,
  });
  Future<Product> insertProduct({
    required String companyId,
    required Product product,
    required CategoryProduct? category,
  });
  Future<Package> insertPackage({
    required String companyId,
    required Package package,
  });

  // DELETE DATA
  Future<void> deleteCategory({required String id});
  Future<void> deleteProduct({required String id});

  // ACTIVATE DATA
  Future<void> activateData({
    required String id,
    required bool value,
    required InventoryType type,
  });
}
