import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';

class GridviewEmployeeWidget extends StatefulWidget {
  final List<Employee>? employees;
  const GridviewEmployeeWidget({super.key, this.employees});

  @override
  State<GridviewEmployeeWidget> createState() => _GridviewEmployeeWidgetState();
}

class _GridviewEmployeeWidgetState extends State<GridviewEmployeeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: widget.employees?.length ?? 0,
        itemBuilder: (context, index) {
          final employee = (widget.employees ?? [])[index];
          return GridEmployeeWidget(employee: employee);
        },
      ),
    );
  }
}
