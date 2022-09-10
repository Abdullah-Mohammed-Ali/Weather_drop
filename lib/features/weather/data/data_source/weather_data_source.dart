import 'package:dio/dio.dart';
import 'package:drop_weather/core/utils_classes/coord.dart';
import 'package:drop_weather/features/weather/data/model/daily_fore_cast_model.dart';
import 'package:drop_weather/features/weather/data/model/weather_info_model.dart';

import '../../../../const/strings.dart';
import '../model/for_cast_model.dart';

class DataSource {
  final Dio _dio;

  DataSource(this._dio);

  Future<Response> getInfoByCoord(Coord coord) async {
    try {
      var response = await _dio
          .request(ApiStringHelper.weatherInfoEndPoint, queryParameters: {
        'lat': coord.lat,
        'lon': coord.lon,
        'appid': ApiStringHelper.apiKey,
        'units': 'metric'
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherInfoModel?> getInfoByCity(String cityName) async {
    try {
      var response = await _dio.request(ApiStringHelper.weatherInfoEndPoint,
          queryParameters: {
            'q': cityName,
            'appid': ApiStringHelper.apiKey,
            'units': 'metric'
          });
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
        'appid': ApiStringHelper.apiKey,
        'units': 'metric '
      });
      List<ForecastingModel> result = [];
      response.data['hourly'].forEach((e) {
        result.add(ForecastingModel.fromJson(e));
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DailyForeCastModel>?> getDailyForecastByCoord(Coord coord) async {
    try {
      var response =
          await _dio.request(ApiStringHelper.oneCallEndPoint, queryParameters: {
        'lat': coord.lat,
        'lon': coord.lon,
        'exclude': 'minutely,hourly',
        'appid': ApiStringHelper.apiKey,
        'units': 'metric '
      });
      List<DailyForeCastModel> result = [];
      print(response.data['daily'].toString());
      response.data['daily'].forEach((e) {
        result.add(DailyForeCastModel.fromJson(e));
      });
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
