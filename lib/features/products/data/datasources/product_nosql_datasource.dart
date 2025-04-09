import 'package:fortuno/features/products/domain/entities/package.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/enums/inventory_type.dart';
import '../model/category_model.dart';
import '../model/package_model.dart';
import '../model/product_model.dart';
import 'products_datasource.dart';

@LazySingleton(as: ProductsDatasource)
class ProductNosqlDatasource extends ProductsDatasource {
  final SupabaseClient client;

  ProductNosqlDatasource({required this.client});

  @override
  Future<List<CategoryModel>> getCategories({required String companyId}) async {
    final response = await client
        .from('category')
        .select()
        .eq('company_id', companyId)
        .eq('is_active', true);

    final result = response.map((e) => CategoryModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<List<ProductModel>> getProductByCategory({
    required String categoryId,
  }) async {
    final response = await client
        .from('category_product')
        .select('*, products!left(*), category!inner(*)')
        .eq('category.ID', categoryId)
        .eq('products.is_active', true);

    final catProduct = <String, dynamic>{};
    final List<Map<String, dynamic>> productsListRaw = [];

    for (var raw in response) {
      if (raw["products"] == null) continue;
      final categoryRaw = raw["category"];
      final productRaw = raw["products"];

      if (catProduct.isEmpty) {
        catProduct["category_id"] = categoryRaw['ID'];
        catProduct["company_id"] = categoryRaw['company_id'];
        catProduct["category_name"] = categoryRaw['category_name'];
        catProduct["category_code"] = categoryRaw['category_code'];
      }

      productsListRaw.add(productRaw);
    }
    catProduct["products"] = productsListRaw;

    final result = productsListRaw.map((e) => ProductModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<List<PackageModel>> getPackageByCategory({
    required String categoryId,
  }) async {
    final params = <String, String>{"category_uuid": categoryId};
    final response =
        await client.rpc('get_packages_by_category', params: params).select();

    final result = response.map((e) => PackageModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<List<ProductModel>> getProductByCompany({
    required String companyId,
  }) async {
    final response = await client
        .from('products')
        .select('*, category_product!left(*, category!left(*))')
        .eq('company_id', companyId)
        .limit(1, referencedTable: 'category_product');

    final List<Map<String, dynamic>> productsListRaw = [];

    for (var raw in response) {
      final cat = raw['category_product'] as List?;
      if (cat != null && cat.isNotEmpty) {
        raw['category'] = cat.first['category'];
      } else {
        raw['category'] = null;
      }

      productsListRaw.add(raw);
    }

    final result = productsListRaw.map((e) => ProductModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<List<PackageModel>> getPackageByCompany({
    required String companyId,
  }) async {
    final params = <String, String>{"company_uuid": companyId};
    final response =
        await client.rpc('get_packages_by_company', params: params).select();

    final result = response.map((e) => PackageModel.fromMap(e)).toList();
    return result;
  }

  @override
  Future<void> insertProduct({
    required String companyId,
    required ProductModel product,
    required CategoryModel? category,
  }) async {
    final map = product.toMap();
    await client.from('products').insert(map);

    if (category != null) {
      final catProdMap = {
        "category_id": category.id,
        "product_id": product.id,
        "created_at": DateTime.now().toString(),
      };
      await client.from('category_product').insert(catProdMap);
    }
  }

  @override
  Future<void> insertCategory({
    required String companyId,
    required CategoryModel category,
  }) async {
    final map = category.toMap();
    await client.from('category').insert(map);
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await client.from('category_product').delete().eq('category_id', id);
    await client.from('category').delete().eq('ID', id);
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    await client.from('category_product').delete().eq('product_id', id);
    await client.from('products').delete().eq('ID', id);
  }

  @override
  Future<void> activateData({
    required String id,
    required bool value,
    required InventoryType type,
  }) async {
    await client.from(type.table).update({'is_active': value}).eq('ID', id);
  }

  @override
  Future<Package> insertPackage({
    required String companyId,
    required Package package,
  }) {
    throw UnimplementedError();
  }
}
