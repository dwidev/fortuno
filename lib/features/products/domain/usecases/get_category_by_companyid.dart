// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:fortuno/features/profile/domain/repo/company_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/category.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetCategoryByCompanyId extends BaseUsecase<List<CategoryProduct>, void> {
  final CompanyRepository companyRepository;
  final ProductsRepository productsRepository;

  GetCategoryByCompanyId({
    required this.companyRepository,
    required this.productsRepository,
  });

  @override
  Future<ReturnFailure<List<CategoryProduct>>> calling(void params) async {
    final companyId = await companyRepository.getCompanyID();
    final response = await productsRepository.getCategories(
      companyId: companyId,
    );
    return Right(response);
  }
}
