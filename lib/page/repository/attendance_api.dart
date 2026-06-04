import 'package:dio/dio.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/service/api.dart';

class AttendanceApi {
  static Future<List<Employee>> get(Map<String, dynamic>? map) async {
    try {
      final client = await Api.restClient(params: map);
      return await client.getEmployee();
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static Future<AttendanceLog> postAttendance(Map<String, dynamic> map) async {
    try {
      final client = await Api.restClient();
      return await client.postAttendance(map);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static String _extractErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final dynamic message =
          data['message'] ?? data['error'] ?? data['errors'];

      if (message is String && message.trim().isNotEmpty) {
        return message;
      }

      if (message is List && message.isNotEmpty) {
        return message.first.toString();
      }

      if (message is Map && message.isNotEmpty) {
        return message.values.first.toString();
      }
    }

    return e.message ?? 'Request failed';
  }
}
