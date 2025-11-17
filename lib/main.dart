import 'package:fl_ga_mhis_hub/injector/get_it.dart';
import 'package:fl_ga_mhis_hub/page/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

void main() async {
  await Jiffy.setLocale('id');
  setupLocator();
  runApp(const EmployeeAttendanceApp());
}

class EmployeeAttendanceApp extends StatelessWidget {
  const EmployeeAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi OB & Security',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const AttendanceScreen(),
    );
  }
}
