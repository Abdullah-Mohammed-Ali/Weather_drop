import 'package:dartz/dartz.dart';
import 'package:drop_weather/error_handling/failure.dart';

import '../../../../core/utils_classes/coord.dart';
import '../../data/model/daily_fore_cast_model.dart';
import '../entities/for_cast_entity.dart';

abstract class RepoWeather<Type> {
  Future<Either<Failures, Type?>?> getWeatherInfoByCoord(Coord coord);
  Future<Either<Failures, Type?>?> getWeatherInfoByCity(String cityName);
  Future<Either<Failures, List<ForecastingEntity>?>?> getWeatherForCastHourly(
      Coord coord);
  Future<Either<Failures, List<DailyForeCastModel>?>?> getWeatherForCastDaily(
      Coord coord);
}
