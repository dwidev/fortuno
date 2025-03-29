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
  Future<void> insertProduct({
    required String companyId,
    required Product product,
    required CategoryProduct? category,
  });
}
