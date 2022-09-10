import 'package:drop_weather/features/weather/domain/entities/for_cast_entity.dart';

import '../../../../core/utils_classes/weather.dart';

class ForecastingModel extends ForecastingEntity {
  ForecastingModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    temp = json['temp'];
    feelsLike = double.parse(json['feels_like'].toString());
    pressure = json['pressure'];
    humidity = json['humidity'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = double.parse(json['wind_speed'].toString());
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;

    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_speed'] = windSpeed;

    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
