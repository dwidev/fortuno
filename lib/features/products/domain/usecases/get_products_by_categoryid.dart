import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../entities/product.dart';
import '../repository/products_repository.dart';

@lazySingleton
class GetProductsByCategoryId extends BaseUsecase<List<Product>, String> {
  final ProductsRepository productsRepository;

  GetProductsByCategoryId({required this.productsRepository});

  @override
  Future<ReturnFailure<List<Product>>> calling(String params) async {
    final response = await productsRepository.getProductByCategory(
      categoryId: params,
    );
    return Right(response);
  }
}
