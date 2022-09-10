import '../../../../core/utils_classes/weather.dart';

class ForecastingEntity {
  int? dt;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  int? clouds;
  int? visibility;
  double? windSpeed;
  double? windGust;
  List<Weather>? weather;

  ForecastingEntity({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windGust,
    this.weather,
  });
}
