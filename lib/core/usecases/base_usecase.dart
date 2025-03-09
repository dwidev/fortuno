import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';

import '../failures/failure.dart';

typedef ReturnFailure<ReturnType> = Either<Failure, ReturnType>;

abstract class BaseUsecase<ReturnType, ParamsType> {
  Future<ReturnFailure<ReturnType>> call(ParamsType paramsType) async {
    try {
      final response = await calling(paramsType);
      return response.fold((left) => Left(left), (right) => Right(right));
    } catch (e) {
      debugPrint("$e");
      if (e is Failure) {
        return Left(e);
      }

      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<ReturnFailure<ReturnType>> calling(ParamsType params);
}
