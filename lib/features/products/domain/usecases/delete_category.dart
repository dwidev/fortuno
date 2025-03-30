import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../repository/products_repository.dart';

@lazySingleton
class DeleteCategory extends BaseUsecase<void, String> {
  final ProductsRepository productsRepository;

  DeleteCategory({required this.productsRepository});

  @override
  Future<ReturnFailure<void>> calling(String params) async {
    await productsRepository.deleteCategory(id: params);
    return Right(null);
  }
}
