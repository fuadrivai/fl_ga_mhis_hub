import 'package:dio/dio.dart';
import 'package:fl_ga_mhis_hub/injector/injector.dart';
import 'package:fl_ga_mhis_hub/service/restclient.dart';

class Api {
  // static const String baseUrl = "http://192.168.204.35:3000/api/";
  // static const String baseUrl = "http://192.168.1.8:3000/api/";
  static const String baseUrl = "https://mhis-hub.mhis.link/api/";

  static restClient({Map<String, dynamic>? params, String? baseurl}) async {
    final dio = Dio();
    dio.interceptors.clear();
    dio.interceptors.add(DioInterceptors(dio));
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Accept"] = "*/*";
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.queryParameters = params ?? {};
    return RestClient(dio, baseUrl: baseurl ?? baseUrl);
  }
}
