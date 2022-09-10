import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:drop_weather/core/functions/date_formatter.dart';
import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_daily_forcast_use_case.dart';
import 'package:drop_weather/features/weather/domain/use_cases/get_weather_info_by_city_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import '../../../../error_handling/failure.dart';
import '../../domain/entities/for_cast_entity.dart';
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

  WeatherInfoEntity? myCityInfo;

  Future<Either<Failures, WeatherInfoEntity?>?> getInfoByCity() async {
    GetWeatherInfoByCityParams params =
        GetWeatherInfoByCityParams(_cityNameFromSearch ?? 'london');
    emit(WeatherGetInfoLoading());
    var result = await _getWeatherInfoByCityUseCase.call(params);
    result?.fold((l) {
      emit(WeatherGetInfoError());
    }, (r) {
      myCityInfo = r;
      myCityInfo?.dateText = dateFormatted(myCityInfo!.date!);
      emit(WeatherGetInfoSuccess());
    });

    await getDailyForecast();
    await getHourlyForecast();
  }

  Future<Either<Failures, List<ForecastingEntity>?>?>
      getHourlyForecast() async {
    GetHourlyForcastParams params = GetHourlyForcastParams(myCityInfo!.coord!);
    emit(WeatherGetHourlyLoading());
    var result = await _hourlyForcastUseCase.call(params);
    print(result);
    result?.fold((l) {
      emit(WeatherGetHourlyError());
      print(l.error);
    }, (r) {
      emit(WeatherGetHourlySuccess());
    });
  }

  Future<void> searchForCity(context) async {
    try {
      await PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyCKXxBgp-klEuTn3T2h7JIsfF5GIN940bM',
        radius: 10000000000,
        types: ['(cities)'],
        strictbounds: false,
        mode: Mode.overlay,
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        components: [],
      ).then((value) async {
        String cityName = value!.description!.split(' ')[0];
        getCityName(cityName);
        await getInfoByCity();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failures, List<ForecastingEntity>?>?> getDailyForecast() async {
    GetDailyForcastParams params = GetDailyForcastParams(myCityInfo!.coord!);
    emit(WeatherGetDailyLoading());
    var result = await _dailyForcastUseCase.call(params);
    result?.fold((l) {
      emit(WeatherGetDailyError());
    }, (r) {
      emit(WeatherGetDailySuccess());
    });
  }
}
