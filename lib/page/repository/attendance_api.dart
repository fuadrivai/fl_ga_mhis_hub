import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/service/api.dart';

class AttendanceApi {
  static Future<List<Employee>> get(Map<String, dynamic>? map) async {
    final client = await Api.restClient(params: map);
    var data = client.getEmployee();
    return data;
  }

  static Future<AttendanceLog> postAttendance(Map<String, dynamic>? map) async {
    final client = await Api.restClient();
    var data = client.postAttendance(map);
    return data;
  }
}
