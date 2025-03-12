import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/package.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetPackageByCategoryid extends BaseUsecase<List<Package>, String> {
  final ProductsRepository productsRepository;

  GetPackageByCategoryid({required this.productsRepository});

  @override
  Future<ReturnFailure<List<Package>>> calling(String params) async {
    final response = await productsRepository.getPackageByCategory(
      categoryId: params,
    );
    return Right(response);
  }
}
