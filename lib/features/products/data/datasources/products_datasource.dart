import '../../domain/enums/inventory_type.dart';
import '../model/category_model.dart';
import '../model/package_model.dart';
import '../model/product_model.dart';

abstract class ProductsDatasource {
  // GET DATA
  Future<List<CategoryModel>> getCategories({required String companyId});
  Future<List<ProductModel>> getProductByCategory({required String categoryId});
  Future<List<ProductModel>> getProductByCompany({required String companyId});
  Future<List<PackageModel>> getPackageByCategory({required String categoryId});
  Future<List<PackageModel>> getPackageByCompany({required String companyId});

  // INSERT DATA
  Future<void> insertCategory({
    required String companyId,
    required CategoryModel category,
  });
  Future<void> insertProduct({
    required String companyId,
    required ProductModel product,
    required CategoryModel? category,
  });
  Future<void> insertPackage({
    required String companyId,
    required PackageModel package,
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
