import 'package:dartz/dartz.dart';
import 'package:drop_weather/error_handling/failure.dart';
import 'package:drop_weather/features/weather/data/data_source/weather_data_source.dart';
import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';

import '../../../../core/utils_classes/coord.dart';
import '../../domain/entities/for_cast_entity.dart';
import '../../domain/repo/repo_contract.dart';

class RepoWeatherImpl implements RepoWeather<WeatherInfoEntity> {
  final DataSource _dataSource;

  RepoWeatherImpl(this._dataSource);

  @override
  Future<Either<Failures, WeatherInfoEntity?>?> getWeatherInfoByCity(
      String cityName) async {
    try {
      var result = await _dataSource.getInfoByCity(cityName);
      return Right(result);
    } catch (e) {
      return Left(HttpFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ForecastingEntity>?>?> getWeatherForCastDaily(
      Coord coord) async {
    try {
      var result = await _dataSource.getDailyForecastByCoord(coord);
      return Right(result);
    } catch (e) {
      return Left(HttpFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ForecastingEntity>?>?> getWeatherForCastHourly(
      Coord coord) async {
    try {
      var result = await _dataSource.getHourlyForecastByCoord(coord);
      return Right(result);
    } catch (e) {
      return Left(HttpFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, WeatherInfoEntity?>?> getWeatherInfoByCoord(
      Coord coord) {
    // TODO: implement getWeatherInfoByCoord
    throw UnimplementedError();
  }
}
