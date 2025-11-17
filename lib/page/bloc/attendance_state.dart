part of 'attendance_bloc.dart';

final class AttendanceState extends Equatable {
  final bool isLoading, isError, isSuccess;
  final String? errorMessage;
  final List<Employee>? employees;
  final Employee? employee;
  final List<Employee>? filterEmployee;
  const AttendanceState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.employees,
    this.filterEmployee,
    this.employee,
  });
  AttendanceState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    List<Employee>? employees,
    List<Employee>? filterEmployee,
    Employee? employee,
  }) {
    return AttendanceState(
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      employees: employees ?? this.employees,
      filterEmployee: filterEmployee ?? this.filterEmployee,
      employee: employee ?? this.employee,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    isLoading,
    isError,
    isSuccess,
    employees,
    filterEmployee,
    employee,
  ];
}
