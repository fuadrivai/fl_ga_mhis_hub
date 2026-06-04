import 'package:dio/dio.dart';
import 'package:fl_ga_mhis_hub/injector/injector.dart';
import 'package:fl_ga_mhis_hub/service/restclient.dart';

class Api {
  // static const String baseUrl = "http://192.168.207.182:3000/";
  static const String baseUrl = "https://mhis-hub.mhis.link/";

  static const String baseApiUrl = "${Api.baseUrl}api/";

  static Future<RestClient> restClient({
    Map<String, dynamic>? params,
    String baseApiUrl = Api.baseApiUrl,
  }) async {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors(dio));
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Accept"] = "*/*";
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.queryParameters = params ?? {};
    return RestClient(dio, baseUrl: baseApiUrl);
  }
}
