import 'package:dartz/dartz.dart';
import 'package:drop_weather/core/use_case.dart';
import 'package:drop_weather/error_handling/failure.dart';
import 'package:drop_weather/features/weather/data/repo/repo_impl.dart';
import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';

class GetWeatherInfoByCityUseCase
    extends UseCase<WeatherInfoEntity, GetWeatherInfoByCityParams> {
  final RepoWeatherImpl _repoWeather;

  GetWeatherInfoByCityUseCase(this._repoWeather);
  @override
  Future<Either<Failures, WeatherInfoEntity?>?> call(parameter) async {
    return await _repoWeather.getWeatherInfoByCity(parameter.city);
  }
}

class GetWeatherInfoByCityParams {
  final String city;

  GetWeatherInfoByCityParams(this.city);
}
