import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/bloc/attendance_bloc.dart';
import 'package:fl_ga_mhis_hub/page/pick_image_screen.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Employee? _selectedEmployee;
  bool _showModal = false;
  // Pagination variables
  final int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AttendanceBloc();
        bloc.add(OnInit());
        return bloc;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                Column(
                  children: [
                    CustomAppbar(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            SearchBarWidget(
                              onChanged: (value) {
                                context.read<AttendanceBloc>().add(
                                  OnSearch(value),
                                );
                              },
                              onPressedClearIcon: () => context
                                  .read<AttendanceBloc>()
                                  .add(OnSearch("")),
                              // viewMode: (val) {
                              //   setState(() => viewMode = val);
                              // },
                              onRefresh: () {
                                context.read<AttendanceBloc>().add(OnInit());
                              },
                            ),
                            Expanded(
                              child: EmployeeWidget(
                                viewMode: ViewMode.list,
                                currentPage: _currentPage,
                                employees: state.filterEmployee,
                                onTap: (employee) {
                                  setState(() {
                                    _showModal = !_showModal;
                                    _selectedEmployee = _showModal
                                        ? employee
                                        : null;
                                  });
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         PickImageScreen(employee: employee),
                                  //   ),
                                  // );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Modal Overlay
                if (_showModal && _selectedEmployee != null)
                  ModalClockWidget(
                    employee: _selectedEmployee,
                    onclose: closeModal,
                    onClockIn: () => navigate("clock_in"),
                    onClockOut: () => navigate("clock_out"),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  closeModal() {
    setState(() {
      _showModal = false;
      _selectedEmployee = null;
    });
  }

  navigate(String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PickImageScreen(type: type, employee: _selectedEmployee!),
      ),
    );
  }
}
