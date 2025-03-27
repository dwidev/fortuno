import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import 'package:fortuno/features/profile/domain/repo/company_repository.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/product.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetProductsByCompany extends BaseUsecase<List<Product>, void> {
  final ProductsRepository productsRepository;
  final CompanyRepository companyRepository;

  GetProductsByCompany({
    required this.productsRepository,
    required this.companyRepository,
  });

  @override
  Future<ReturnFailure<List<Product>>> calling(void params) async {
    final companyId = await companyRepository.getCompanyID();
    final response = await productsRepository.getProductByCompany(
      companyId: companyId,
    );
    return Right(response);
  }
}
