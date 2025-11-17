import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';

class EmployeeWidget extends StatefulWidget {
  final List<Employee>? employees;
  final ViewMode? viewMode;
  final int currentPage;
  final Function(Employee)? onTap;
  const EmployeeWidget({
    super.key,
    this.employees,
    required this.currentPage,
    this.viewMode,
    this.onTap,
  });

  @override
  State<EmployeeWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<EmployeeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            countEmployee: widget.employees?.length ?? 0,
            currentPage: widget.currentPage,
          ),
          if ((widget.employees ?? []).isEmpty)
            CardEmptyWidget()
          else
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: widget.viewMode == ViewMode.list
                        ? ListviewEmployeeWidget(
                            employees: widget.employees,
                            onTap: widget.onTap,
                          )
                        : GridviewEmployeeWidget(employees: widget.employees),
                  ),
                  // PaginationWidget(
                  //   currentPage: widget.currentPage,
                  //   totalPage: totalPages,
                  // ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final int countEmployee;
  final int currentPage;
  const TitleWidget({
    super.key,
    required this.countEmployee,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'List Karyawan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[900],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$countEmployee Karyawan',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
