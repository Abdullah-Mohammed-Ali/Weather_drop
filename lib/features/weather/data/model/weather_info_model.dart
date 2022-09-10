import 'package:drop_weather/features/weather/domain/entities/weatherInfoEntity.dart';

import '../../../../core/utils_classes/coord.dart';
import '../../../../core/utils_classes/weather.dart';

class WeatherInfoModel extends WeatherInfoEntity {
  WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    print(json['coord']);
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    date = json['dt'] != null ? int.parse(json['dt'].toString()) : null;
    dateText = json['dt_txt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    rain = json['rain'] != null ? Rain.fromJson(json['rain']) : null;
    clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (rain != null) {
      data['rain'] = rain!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    if (name != null) {
      data['name'] = name;
    }
    return data;
  }
}
