import 'package:injectable/injectable.dart';

import '../../domain/entities/category.dart';
import '../../domain/repository/products_repository.dart';
import '../datasources/products_datasource.dart';

@LazySingleton(as: ProductsRepository)
class ProductsRepositoryImpl extends ProductsRepository {
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
}
