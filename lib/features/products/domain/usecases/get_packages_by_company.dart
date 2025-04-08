import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../../../profile/domain/repo/company_repository.dart';
import '../entities/package.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetPackagesByCompany extends BaseUsecase<List<Package>, void> {
  final ProductsRepository productsRepository;
  final CompanyRepository companyRepository;

  GetPackagesByCompany({
    required this.productsRepository,
    required this.companyRepository,
  });

  @override
  Future<ReturnFailure<List<Package>>> calling(void params) async {
    final companyId = await companyRepository.getCompanyID();
    final response = await productsRepository.getPackageByCompany(
      companyId: companyId,
    );
    return Right(response);
  }
}
