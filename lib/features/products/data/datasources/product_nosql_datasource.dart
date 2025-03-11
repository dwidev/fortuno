import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/category_model.dart';
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
        .eq('company_id', companyId);

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
        .eq('category.ID', categoryId);

    final catProduct = <String, dynamic>{};
    final List<Map<String, dynamic>> productsListRaw = [];

    for (var raw in response) {
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
}
