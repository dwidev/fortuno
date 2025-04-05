import 'package:either_dart/either.dart';
import 'package:fortuno/core/core.dart';
import '../enums/inventory_type.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/base_usecase.dart';
import '../repository/products_repository.dart';

@lazySingleton
class ActivateData extends BaseUsecase<bool, ActivateDataParams> {
  final ProductsRepository productsRepository;

  ActivateData({required this.productsRepository});

  @override
  Future<ReturnFailure<bool>> calling(ActivateDataParams params) async {
    await productsRepository.activateData(
      id: params.id,
      value: params.value,
      type: params.type,
    );
    return Right(params.value);
  }
}

class ActivateDataParams {
  final String id;
  final bool value;
  final InventoryType type;

  ActivateDataParams({
    required this.id,
    required this.value,
    required this.type,
  });
}
