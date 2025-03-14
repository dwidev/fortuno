import 'package:fortuno/features/products/domain/entities/package.dart';

import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<CategoryProduct>> getCategories({required String companyId});
  Future<List<Product>> getProductByCategory({required String categoryId});
  Future<List<Package>> getPackageByCategory({required String categoryId});
}
