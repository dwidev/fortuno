part of 'base_usecase.dart';

typedef ResponseListEihter<T> = List<Either<Failure, List<T>>>;
typedef ReturnFailure<T> = Either<Failure, T>;
typedef FutureReturn<T> = Future<ReturnFailure<T>>;
