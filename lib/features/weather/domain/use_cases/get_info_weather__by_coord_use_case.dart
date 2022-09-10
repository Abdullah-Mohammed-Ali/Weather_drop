import 'package:dartz/dartz.dart';
import 'package:drop_weather/core/utils_classes/coord.dart';
import 'package:drop_weather/error_handling/failure.dart';
import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';

import '../../../../core/use_case.dart';
import '../../data/repo/repo_impl.dart';

class GetCityWeatherUseCase
    extends UseCase<WeatherInfoEntity?, WeatherInfoParams> {
  final RepoWeatherImpl _repoWeather;

  GetCityWeatherUseCase(this._repoWeather);

  @override
  Future<Either<Failures, WeatherInfoEntity?>?> call(parameter) async {
    return await _repoWeather.getWeatherInfoByCoord(parameter.cityCoord);
  }
}

class WeatherInfoParams {
  final Coord cityCoord;

  WeatherInfoParams(this.cityCoord);
}
