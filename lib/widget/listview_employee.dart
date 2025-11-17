import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';

class ListviewEmployeeWidget extends StatefulWidget {
  final List<Employee>? employees;
  final Function(Employee)? onTap;
  const ListviewEmployeeWidget({super.key, this.employees, this.onTap});

  @override
  State<ListviewEmployeeWidget> createState() => _ListviewEmployeeWidgetState();
}

class _ListviewEmployeeWidgetState extends State<ListviewEmployeeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.employees?.length ?? 0,
      itemBuilder: (context, index) {
        Employee employee = widget.employees![index];
        return InkWell(
          onTap: () {
            widget.onTap!(employee);
          },
          child: CardEmployeeWidget(employee: employee),
        );
      },
    );
  }
}
