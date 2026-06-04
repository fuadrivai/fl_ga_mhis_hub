import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/employee_detail_screen.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';

class EmployeeSettingScreen extends StatefulWidget {
  final List<Employee> employees;

  const EmployeeSettingScreen({super.key, required this.employees});

  @override
  State<EmployeeSettingScreen> createState() => _EmployeeSettingScreenState();
}

class _EmployeeSettingScreenState extends State<EmployeeSettingScreen> {
  late List<Employee> _filteredEmployees;
  final int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _filteredEmployees = List<Employee>.from(widget.employees);
  }

  void _onSearch(String value) {
    final query = value.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredEmployees = List<Employee>.from(widget.employees);
        return;
      }

      _filteredEmployees = widget.employees.where((employee) {
        final name = (employee.personal?.fullname ?? '').toLowerCase();
        final position = (employee.employment?.jobPositionName ?? '')
            .toLowerCase();
        final organization = (employee.employment?.organizationName ?? '')
            .toLowerCase();
        final idTalenta = (employee.idTalenta ?? '').toLowerCase();

        return name.contains(query) ||
            position.contains(query) ||
            organization.contains(query) ||
            idTalenta.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Employee Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            SearchBarWidget(
              onChanged: _onSearch,
              onPressedClearIcon: () => _onSearch(''),
              onRefresh: () {
                setState(() {
                  _filteredEmployees = List<Employee>.from(widget.employees);
                });
              },
            ),
            EmployeeWidget(
              viewMode: ViewMode.list,
              currentPage: _currentPage,
              employees: _filteredEmployees,
              onTap: (employee) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmployeeDetailScreen(employee: employee),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
