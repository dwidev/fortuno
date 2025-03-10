import '../model/category_model.dart';

abstract class ProductsDatasource {
  Future<List<CategoryModel>> getCategories({required String companyId});
}
