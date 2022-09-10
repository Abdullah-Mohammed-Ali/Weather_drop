import 'package:dartz/dartz.dart';
import 'package:drop_weather/error_handling/failure.dart';

abstract class UseCase<Type, Parameter> {
  Future<Either<Failures, Type?>?> call(Parameter parameter);
}
