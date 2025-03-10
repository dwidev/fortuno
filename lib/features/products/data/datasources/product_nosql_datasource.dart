import 'dart:convert';

import 'package:fortuno/features/products/data/datasources/products_datasource.dart';
import 'package:fortuno/features/products/data/model/category_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
}
