part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class OnInit extends AttendanceEvent {
  const OnInit();
  @override
  List<Object?> get props => [];
}

class OnSearch extends AttendanceEvent {
  final String val;
  const OnSearch(this.val);
  @override
  List<Object?> get props => [];
}
