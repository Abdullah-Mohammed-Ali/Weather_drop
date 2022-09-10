import 'package:dartz/dartz.dart';
import 'package:drop_weather/core/utils_classes/coord.dart';
import 'package:drop_weather/error_handling/failure.dart';

import '../../../../core/use_case.dart';
import '../../data/repo/repo_impl.dart';
import '../entities/for_cast_entity.dart';

class GetHourlyForcastUseCase
    extends UseCase<List<ForecastingEntity>?, GetHourlyForcastParams> {
  final RepoWeatherImpl _repoWeather;

  GetHourlyForcastUseCase(this._repoWeather);
  @override
  Future<Either<Failures, List<ForecastingEntity>?>?> call(
      GetHourlyForcastParams parameter) async {
    return await _repoWeather.getWeatherForCastHourly(parameter.coord);
  }
}

class GetHourlyForcastParams {
  final Coord coord;

  GetHourlyForcastParams(this.coord);
}
