import 'package:dartz/dartz.dart';
import 'package:drop_weather/core/utils_classes/coord.dart';
import 'package:drop_weather/error_handling/failure.dart';

import '../../../../core/use_case.dart';
import '../../data/repo/repo_impl.dart';
import '../entities/for_cast_entity.dart';

class GetDailyForcastUseCase
    extends UseCase<List<ForecastingEntity>?, GetDailyForcastParams> {
  final RepoWeatherImpl _repoWeather;

  GetDailyForcastUseCase(this._repoWeather);
  @override
  Future<Either<Failures, List<ForecastingEntity>?>?> call(
      GetDailyForcastParams parameter) async {
    return await _repoWeather.getWeatherForCastDaily(parameter.coord);
  }
}

class GetDailyForcastParams {
  final Coord coord;

  GetDailyForcastParams(this.coord);
}
