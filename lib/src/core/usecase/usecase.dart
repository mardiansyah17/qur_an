import 'package:dartz/dartz.dart';
import 'package:qur_an/src/core/errors/failures.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
