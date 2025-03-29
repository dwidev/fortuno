import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/package.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/products_repository.dart';
import '../datasources/products_datasource.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

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

  @override
  Future<void> insertProduct({
    required String companyId,
    required Product product,
    required CategoryProduct? category,
  }) {
    final productModel = ProductModel(
      id: Uuid().v4(),
      name: product.name,
      code: product.code,
      price: product.price,
      createAt: product.createAt,
      isActive: product.isActive,
    );

    CategoryModel? categoryModel;

    if (category != null) {
      categoryModel = CategoryModel(
        id: Uuid().v4(),
        name: category.name,
        code: category.code,
        haveProduct: category.haveProduct,
        price: category.price,
        createAt: category.createAt,
      );
    }

    return productsDatasource.insertProduct(
      companyId: companyId,
      product: productModel,
      category: categoryModel,
    );
  }
}
