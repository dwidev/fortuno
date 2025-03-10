part of 'base_usecase.dart';

typedef ResponseListEihter<T> = List<Either<Failure, List<T>>>;
typedef ReturnFailure<ReturnType> = Either<Failure, ReturnType>;
typedef FutureReturn<ReturnType> = Future<ReturnFailure<ReturnType>>;
