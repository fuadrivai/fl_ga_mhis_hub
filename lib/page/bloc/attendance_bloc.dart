import 'package:equatable/equatable.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/repository/attendance_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(const AttendanceState()) {
    on<OnInit>(_onInit);
    on<OnSearch>(_onSearch);
  }

  void _onInit(OnInit event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(isLoading: true, isError: false, isSuccess: false));
    try {
      List<Employee> employees = await AttendanceApi.get({
        "name": "Support Staff",
      });
      emit(
        state.copyWith(
          isLoading: false,
          isError: false,
          isSuccess: true,
          employees: employees,
          filterEmployee: employees,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSearch(OnSearch event, Emitter<AttendanceState> emit) {
    if (event.val.isEmpty) {
      emit(state.copyWith(filterEmployee: state.employees));
    }
    List<Employee> emps = (state.employees ?? []).where((e) {
      final fullname = (e.personal?.fullname ?? "").toLowerCase();
      final position = (e.employment?.jobPositionName ?? "").toLowerCase();
      final department = (e.employment?.organizationName ?? "").toLowerCase();
      final query = event.val.toLowerCase();
      return fullname.contains(query) ||
          position.contains(query) ||
          department.contains(query);
    }).toList();

    emit(state.copyWith(filterEmployee: emps));
  }
}
