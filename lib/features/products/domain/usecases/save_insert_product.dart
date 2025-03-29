// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:fortuno/features/products/domain/entities/product.dart';
import 'package:fortuno/features/profile/domain/repo/company_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/category.dart';
import '../repository/products_repository.dart';

@lazySingleton
class SaveInsertProduct extends BaseUsecase<void, SaveInsertProductParams> {
  final CompanyRepository companyRepository;
  final ProductsRepository productsRepository;

  SaveInsertProduct({
    required this.companyRepository,
    required this.productsRepository,
  });

  @override
  Future<ReturnFailure<void>> calling(SaveInsertProductParams params) async {
    final companyId = await companyRepository.getCompanyID();
    await productsRepository.insertProduct(
      companyId: companyId,
      product: params.product,
      category: params.category,
    );
    return Right(null);
  }
}

class SaveInsertProductParams {
  final Product product;
  final CategoryProduct? category;

  SaveInsertProductParams({required this.product, required this.category});
}
