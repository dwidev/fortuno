import 'package:either_dart/either.dart';
import '../entities/package.dart';
import '../../../profile/domain/repo/company_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../repository/products_repository.dart';

@lazySingleton
class SaveInsertPackage extends BaseUsecase<Package, SaveInsertPackageParams> {
  final CompanyRepository companyRepository;
  final ProductsRepository productsRepository;

  SaveInsertPackage({
    required this.companyRepository,
    required this.productsRepository,
  });

  @override
  Future<ReturnFailure<Package>> calling(SaveInsertPackageParams params) async {
    final companyId = await companyRepository.getCompanyID();
    final product = await productsRepository.insertPackage(
      companyId: companyId,
      package: params.package,
    );
    return Right(product);
  }
}

class SaveInsertPackageParams {
  final Package package;

  SaveInsertPackageParams({required this.package});
}
