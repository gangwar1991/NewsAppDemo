import 'package:NewsApp/data/api/api_constants.dart';
import 'package:NewsApp/data/api/api_response.dart';
import 'package:NewsApp/data/api/api_service.dart';
import 'package:dio/dio.dart';

class HomeProvider {
  HomeProvider({this.api});
  ApiService api;

  ///this method is calling news_feed API

  Future<ApiResponse> getNewsList() async {
    try {
      final response = await api.dio.get(ApiConstants.POPULAR_NEWS,
          options: Options(
              method: 'GET',
              contentType: "application/json",
              responseType: ResponseType.json // or ResponseType.JSON
              ));

      return ApiResponse.success(response);
    } on DioError catch (e) {
      return ApiResponse.failure(e);
    }
  }

  Future<ApiResponse> getTeslaList() async {
    try {
      final response = await api.dio.get(ApiConstants.TESLA_NEWS,
          options: Options(
              method: 'GET',
              contentType: "application/json",
              responseType: ResponseType.json // or ResponseType.JSON
              ));

      return ApiResponse.success(response);
    } on DioError catch (e) {
      return ApiResponse.failure(e);
    }
  }
}
