import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../../../profile/domain/repo/company_repository.dart';
import '../entities/category.dart';
import '../repository/products_repository.dart';

@lazySingleton
class SaveInsertCategory extends BaseUsecase<void, SaveInsertCategoryParams> {
  final CompanyRepository companyRepository;
  final ProductsRepository productsRepository;

  SaveInsertCategory({
    required this.companyRepository,
    required this.productsRepository,
  });

  @override
  Future<ReturnFailure<void>> calling(SaveInsertCategoryParams params) async {
    final companyId = await companyRepository.getCompanyID();
    await productsRepository.insertCategory(
      companyId: companyId,
      category: params.category,
    );
    return Right(null);
  }
}

class SaveInsertCategoryParams {
  final CategoryProduct category;

  SaveInsertCategoryParams({required this.category});
}
