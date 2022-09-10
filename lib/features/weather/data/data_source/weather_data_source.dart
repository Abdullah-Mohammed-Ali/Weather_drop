import 'package:dio/dio.dart';
import 'package:drop_weather/core/utils_classes/coord.dart';
import 'package:drop_weather/features/weather/data/model/weather_info_model.dart';

import '../../../../const/strings.dart';
import '../model/for_cast_model.dart';

class DataSource {
  final Dio _dio;

  DataSource(this._dio);

  Future<Response> getInfoByCoord(Coord coord) async {
    try {
      var response = await _dio.request(ApiStringHelper.weatherInfoEndPoint,
          queryParameters: {
            'lat': coord.lat,
            'lon': coord.lon,
            'appid': ApiStringHelper.apiKey
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherInfoModel?> getInfoByCity(String cityName) async {
    try {
      var response = await _dio.request(ApiStringHelper.weatherInfoEndPoint,
          queryParameters: {'q': cityName, 'appid': ApiStringHelper.apiKey});
      print(response.data);
      return WeatherInfoModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ForecastingModel>?> getHourlyForecastByCoord(Coord coord) async {
    try {
      var response =
          await _dio.request(ApiStringHelper.oneCallEndPoint, queryParameters: {
        'lat': coord.lat,
        'lon': coord.lon,
        'exclude': 'minutely,daily',
        'appid': ApiStringHelper.apiKey
      });
      List<ForecastingModel> result = [];
      response.data['hourly'].forEach((e) {
        result.add(ForecastingModel.fromJson(e));
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ForecastingModel>?> getDailyForecastByCoord(Coord coord) async {
    try {
      var response =
          await _dio.request(ApiStringHelper.oneCallEndPoint, queryParameters: {
        'lat': coord.lat,
        'lon': coord.lon,
        'exclude': 'minutely,hourly',
        'appid': ApiStringHelper.apiKey
      });
      List<ForecastingModel> result = [];
      response.data['daily'].forEach((e) {
        result.add(ForecastingModel.fromJson(e));
      });
    } catch (e) {
      rethrow;
    }
  }
}
