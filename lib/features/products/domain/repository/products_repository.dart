import '../entities/category.dart';

abstract class ProductsRepository {
  Future<List<CategoryProduct>> getCategories({required String companyId});
}
