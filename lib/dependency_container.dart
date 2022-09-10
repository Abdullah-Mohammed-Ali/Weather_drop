import 'package:dio/dio.dart';
import 'package:drop_weather/features/weather/data/data_source/weather_data_source.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_daily_forcast_use_case.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_hourly_fore_cast_use_case.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_weather_info_by_city_use_case.dart';
import 'package:drop_weather/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:get_it/get_it.dart';

import 'const/strings.dart';
import 'features/weather/data/repo/repo_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // cubit
  sl.registerFactory(() => WeatherCubit(sl(), sl(), sl()));
  //use cases
  sl.registerLazySingleton(() => GetWeatherInfoByCityUseCase(
        sl(),
      ));
  sl.registerLazySingleton(() => GetDailyForcastUseCase(
        sl(),
      ));
  sl.registerLazySingleton(() => GetHourlyForcastUseCase(
        sl(),
      ));
  //repe
  sl.registerLazySingleton(() => RepoWeatherImpl(sl()));

  BaseOptions _options = BaseOptions(baseUrl: ApiStringHelper.baseUrl);
  Dio _dio = Dio(_options);
  // data source
  sl.registerLazySingleton(() => DataSource(_dio));
}
