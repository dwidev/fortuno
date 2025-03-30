import 'package:fortuno/features/products/data/model/package_model.dart';
import 'package:fortuno/features/products/data/model/product_model.dart';

import '../model/category_model.dart';

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
}
