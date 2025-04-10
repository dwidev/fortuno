import 'package:fortuno/features/products/data/model/package_model.dart';
import 'package:fortuno/features/products/domain/enums/inventory_type.dart';
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
  Future<Product> insertProduct({
    required String companyId,
    required Product product,
    required CategoryProduct? category,
  }) async {
    final prod = product.copyWith(id: Uuid().v4());
    final productModel = ProductModel(
      id: prod.id,
      companyId: companyId,
      name: prod.name,
      code: prod.code,
      price: prod.price,
      createAt: prod.createAt,
      isActive: prod.isActive,
    );

    CategoryModel? categoryModel;

    if (category != null) {
      categoryModel = CategoryModel(
        companyId: companyId,
        id: category.id,
        name: category.name,
        code: category.code,
        haveProduct: category.haveProduct,
        price: category.price,
        createAt: category.createAt,
      );
    }

    await productsDatasource.insertProduct(
      companyId: companyId,
      product: productModel,
      category: categoryModel,
    );

    return prod;
  }

  @override
  Future<CategoryProduct> insertCategory({
    required String companyId,
    required CategoryProduct category,
  }) async {
    final cat = category.copyWith(id: Uuid().v4());
    final categoryModel = CategoryModel(
      id: cat.id,
      companyId: companyId,
      name: cat.name,
      code: cat.code,
      haveProduct: cat.haveProduct,
      price: cat.price,
      isActive: cat.isActive,
      createAt: cat.createAt,
    );

    await productsDatasource.insertCategory(
      companyId: companyId,
      category: categoryModel,
    );

    return cat;
  }

  @override
  Future<void> deleteCategory({required String id}) {
    return productsDatasource.deleteCategory(id: id);
  }

  @override
  Future<void> deleteProduct({required String id}) {
    return productsDatasource.deleteProduct(id: id);
  }

  @override
  Future<void> activateData({
    required String id,
    required bool value,
    required InventoryType type,
  }) async {
    return productsDatasource.activateData(id: id, value: value, type: type);
  }

  @override
  Future<Package> insertPackage({
    required String companyId,
    required Package package,
  }) async {
    final pack = package.copyWith(id: Uuid().v4());
    final catModel = CategoryModel(
      id: pack.category?.id ?? "",
      companyId: companyId,
      name: pack.category?.name ?? "",
      code: pack.category?.code ?? "",
      haveProduct: pack.category?.haveProduct ?? false,
      price: pack.category?.price ?? 0.0,
      createAt: pack.category?.createAt ?? "",
    );

    final packageModel = PackageModel(
      id: pack.id,
      name: pack.name,
      code: pack.code,
      price: pack.price,
      isActive: pack.isActive,
      createAt: pack.createAt,
      categoryModel: catModel,
      productModel:
          package.items.map((e) {
            return ProductModel(
              id: e.id,
              name: e.name,
              code: e.code,
              price: e.price,
              createAt: e.createAt,
              companyId: companyId,
              isActive: e.isActive,
            );
          }).toList(),
    );

    await productsDatasource.insertPackage(
      companyId: companyId,
      package: packageModel,
    );

    return pack;
  }
}
