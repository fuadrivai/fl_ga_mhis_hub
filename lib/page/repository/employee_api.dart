import 'package:fl_ga_mhis_hub/service/api.dart';

class EmployeeApi {
  static Future postFaceApi(Map<String, dynamic> map) async {
    final client = await Api.restClient();
    var data = client.postFaceEmployee(map);
    return data;
  }
}
