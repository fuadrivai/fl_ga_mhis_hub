import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/page/camera_page.dart';
import 'package:fl_ga_mhis_hub/service/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final employee = widget.employee;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Employee Detail')),
      body: SelectionArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth >= 900;
            final leftWidth = isWideScreen ? constraints.maxWidth * 0.30 : null;

            final leftPanel = _buildLeftPanel(context, employee);
            final rightPanel = _buildRightPanel(employee);

            if (!isWideScreen) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [leftPanel, const SizedBox(height: 16), rightPanel],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: leftWidth, child: leftPanel),
                  const SizedBox(width: 16),
                  Expanded(child: SingleChildScrollView(child: rightPanel)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLeftPanel(BuildContext context, Employee employee) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 62,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundImage: _buildAvatarImage(employee.personal?.avatar),
                child: _buildAvatarImage(employee.personal?.avatar) == null
                    ? Icon(
                        Icons.person_rounded,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _onTapEditPhoto(context),
                    child: const Padding(
                      padding: EdgeInsets.all(9),
                      child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: SelectableText(
              employee.isActive == true ? 'Active' : 'Inactive',
              style: const TextStyle(
                color: Color(0xFF027A48),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SelectableText(
            employee.personal?.fullname ?? '-',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          SelectableText(
            employee.employment?.jobPositionName ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          SelectableText(
            employee.employment?.organizationName ?? '-',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel(Employee employee) {
    final employment = employee.employment;

    return Column(
      children: [
        _buildInfoSection(
          title: 'Employment Information',
          items: [
            _InfoItem('Talenta ID', employee.idTalenta),
            _InfoItem('Employee ID', employment?.employeeId),
            _InfoItem('Organization', employment?.organizationName),
            _InfoItem('Job Position', employment?.jobPositionName),
            _InfoItem('Job Level', employment?.jobLevelName),
            _InfoItem('Branch', employment?.branchName),
            _InfoItem('Employment Status', employment?.employmentStatus),
            _InfoItem('Join Date', employment?.joinDate),
            _InfoItem('End Date', employment?.endDate),
            _InfoItem('Resign Date', employment?.resignDate),
            _InfoItem('Barcode', employment?.barcode),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<_InfoItem> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => _buildInfoRow(item.label, item.value)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: SelectableText(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              (value == null || value.trim().isEmpty) ? '-' : value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _buildAvatarImage(String? avatarPath) {
    if (avatarPath == null || avatarPath.isEmpty) {
      return null;
    }
    return NetworkImage('${Api.baseUrl}storage/$avatarPath');
  }

  void _onTapEditPhoto(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CameraPage(employee: widget.employee)),
    );
  }
}

class _InfoItem {
  final String label;
  final String? value;

  const _InfoItem(this.label, this.value);
}
