import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static Dio inia() {
    return dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? query,
    //String lang = 'en',
    //String? token
  }) async {
    /* dio.options.headers = <String, dynamic>{
      'lang': lang,
      'Authorization': token ?? '',
      'contentType': 'application/json',
    }; */
    return await dio.get<Map<String, dynamic>>(url, queryParameters: query);
  }

  /*  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = <String, dynamic>{
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json'
    };

    return await dio.post<dynamic>(url, queryParameters: query, data: data);
  } */
}
