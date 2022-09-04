import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData(
      {required url, required Map<String, dynamic> query}) async {
    return await dio?.get(url, queryParameters: query);
  }
}


//TODO ->  api key = b4bf465614544fe1841b1667074574ac
//TODO ->  api  = https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b4bf465614544fe1841b1667074574ac
