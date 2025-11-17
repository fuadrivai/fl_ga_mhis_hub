import 'package:dio/dio.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:retrofit/retrofit.dart';

part 'restclient.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("employee/job-level")
  Future<List<Employee>> getEmployee();

  @POST("post/attendance/ga")
  Future<AttendanceLog> postAttendance(@Body() Map<String, dynamic> map);
}
