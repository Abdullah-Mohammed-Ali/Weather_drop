part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherGetCityName extends WeatherState {}

class WeatherGetInfoLoading extends WeatherState {}

class WeatherGetInfoSuccess extends WeatherState {}

class WeatherGetInfoError extends WeatherState {}

class WeatherGetHourlyLoading extends WeatherState {}

class WeatherGetHourlySuccess extends WeatherState {}

class WeatherGetHourlyError extends WeatherState {}

class WeatherGetDailyLoading extends WeatherState {}

class WeatherGetDailySuccess extends WeatherState {}

class WeatherGetDailyError extends WeatherState {}
