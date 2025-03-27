import 'package:injectable/injectable.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/products_repository.dart';
import '../datasources/products_datasource.dart';

@LazySingleton(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource productsDatasource;

  ProductsRepositoryImpl({required this.productsDatasource});

  @override
  Future<List<CategoryProduct>> getCategories({
    required String companyId,
  }) async {
    final response = await productsDatasource.getCategories(
      companyId: companyId,
    );
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }

  @override
  Future<List<Product>> getProductByCategory({
    required String categoryId,
  }) async {
    final response = await productsDatasource.getProductByCategory(
      categoryId: categoryId,
    );
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }

  @override
  Future<List<Package>> getPackageByCategory({
    required String categoryId,
  }) async {
    final response = await productsDatasource.getPackageByCategory(
      categoryId: categoryId,
    );
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }

  @override
  Future<List<Product>> getProductByCompany({required String companyId}) async {
    final response = await productsDatasource.getProductByCompany(
      companyId: companyId,
    );
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }

  @override
  Future<List<Package>> getPackageByCompany({required String companyId}) async {
    final response = await productsDatasource.getPackageByCompany(
      companyId: companyId,
    );
    final result = response.map((e) => e.toEntity()).toList();
    return result;
  }
}
