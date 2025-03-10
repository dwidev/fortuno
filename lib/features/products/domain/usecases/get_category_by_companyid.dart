import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/category.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetCategoryByCompanyId
    extends BaseUsecase<List<CategoryProduct>, String> {
  final ProductsRepository productsRepository;

  GetCategoryByCompanyId({required this.productsRepository});

  @override
  Future<ReturnFailure<List<CategoryProduct>>> calling(String params) async {
    final response = await productsRepository.getCategories(companyId: params);
    return Right(response);
  }
}
