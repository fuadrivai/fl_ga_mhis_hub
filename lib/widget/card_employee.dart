import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:fl_ga_mhis_hub/service/api.dart';
import 'package:flutter/material.dart';

class CardEmployeeWidget extends StatefulWidget {
  final Employee? employee;
  const CardEmployeeWidget({super.key, this.employee});

  @override
  State<CardEmployeeWidget> createState() => _CardEmployeeWidgetState();
}

class _CardEmployeeWidgetState extends State<CardEmployeeWidget> {
  bool isHovered = false;
  Person? get personal => widget.employee?.personal;
  Employment? get employment => widget.employee?.employment;
  ActiveSchedule? get schedule => widget.employee?.activeSchedule;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;
    final bool isExtraSmallScreen = screenWidth < 380;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
                : Colors.grey[200]!,
            width: isHovered ? 1.5 : 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, isHovered ? -6.0 : 0.0, 0.0, 1.0),

        child: isSmallScreen
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAvatar(context),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                fontSize: isHovered ? 16 : 15,
                                fontWeight: FontWeight.w600,
                                color: isHovered
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black,
                              ),
                              child: Text(
                                personal?.fullname ?? "--",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${employment?.jobPositionName ?? "-"} • ${employment?.organizationName ?? "-"}',
                              maxLines: isExtraSmallScreen ? 3 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: isExtraSmallScreen ? 12 : 13,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildChevron(context),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildScheduleChip(isExtraSmallScreen),
                  ),
                ],
              )
            : Row(
                children: [
                  _buildAvatar(context),
                  const SizedBox(width: 16),

                  // Employee Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: isHovered ? 17 : 16,
                            fontWeight: FontWeight.w600,
                            color: isHovered
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black,
                          ),
                          child: Text(
                            "${personal?.fullname ?? "--"} - ${employment?.employeeId ?? "--"}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${employment?.jobPositionName ?? "-"} • ${employment?.organizationName ?? "-"}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status Indicator with hover animation
                  _buildScheduleChip(false),

                  const SizedBox(width: 16),

                  // Action Icon with hover animation
                  _buildChevron(context),
                ],
              ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return personal?.avatar != null &&
            personal!.avatar!.isNotEmpty &&
            personal!.avatar != ""
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isHovered ? 52 : 48,
            height: isHovered ? 52 : 48,
            child: ClipOval(
              child: Image.network(
                "${Api.baseUrl}storage/${personal!.avatar!}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _avatarFallback(context);
                },
              ),
            ),
          )
        : AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isHovered ? 52 : 48,
            height: isHovered ? 52 : 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              Icons.person_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: isHovered ? 26 : 24,
            ),
          );
  }

  Widget _buildScheduleChip(bool isCompact) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 12,
        vertical: isCompact ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF22C55E),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              'Schedule : ${schedule?.scheduleName ?? "-"}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF166534),
                fontSize: isCompact ? 11 : 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChevron(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.identity()
        ..translateByDouble(0.0, isHovered ? 4.0 : 0.0, 0.0, 1.0),

      child: Icon(
        Icons.chevron_right_rounded,
        color: isHovered
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[400],
        size: isHovered ? 22 : 20,
      ),
    );
  }

  Widget _avatarFallback(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: Icon(
        Icons.person_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: isHovered ? 26 : 24,
      ),
    );
  }
}
