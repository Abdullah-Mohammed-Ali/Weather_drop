import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_daily_forcast_use_case.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_weather_info_by_city_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import '../../../../error_handling/failure.dart';
import '../../domain/use_cases/get_hourly_fore_cast_use_case.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._getWeatherInfoByCityUseCase, this._dailyForcastUseCase,
      this._hourlyForcastUseCase)
      : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);
  final GetWeatherInfoByCityUseCase _getWeatherInfoByCityUseCase;
  final GetDailyForcastUseCase _dailyForcastUseCase;
  final GetHourlyForcastUseCase _hourlyForcastUseCase;
  String? _cityNameFromSearch;

  void getCityName(String city) {
    _cityNameFromSearch = city;
    emit(WeatherGetCityName());
  }

  void locationService() async {
    Location location = Location();
    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      print('error service granted');
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    } else {
      print('error permission granted');
    }

    await location
        .getLocation()
        .then((value) => print('${value.latitude} , ${value.longitude}'));
    print('done');
  }

  Future<Either<Failures, WeatherInfoEntity?>?> getInfoByCity() async {
    print('start');
    GetWeatherInfoByCityParams params =
        GetWeatherInfoByCityParams(_cityNameFromSearch ?? 'london');
    var result = await _getWeatherInfoByCityUseCase.call(params);
    print(result);
    result?.fold(
        (l) => SnackBar(
              content: Text(l.error),
            ),
        (r) => print(r!.name));
  }
}
