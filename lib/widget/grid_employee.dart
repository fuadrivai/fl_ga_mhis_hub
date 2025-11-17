import 'package:fl_ga_mhis_hub/model/models.dart';
import 'package:flutter/material.dart';

class GridEmployeeWidget extends StatefulWidget {
  final Employee? employee;
  const GridEmployeeWidget({super.key, this.employee});

  @override
  State<GridEmployeeWidget> createState() => _GridEmployeeWidgetState();
}

class _GridEmployeeWidgetState extends State<GridEmployeeWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
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

        child: GestureDetector(
          // onTap: () => _showClockModal(employee),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header with Avatar and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar with hover animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isHovered ? 36 : 32,
                      height: isHovered ? 36 : 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        boxShadow: isHovered
                            ? [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: isHovered ? 18 : 16,
                      ),
                    ),
                    // Status Indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: isHovered
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF22C55E,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'In',
                            style: TextStyle(
                              color: const Color(0xFF166534),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Employee Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Employee Name
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: isHovered ? 13 : 12,
                          fontWeight: FontWeight.w600,
                          color: isHovered
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        child: Text(
                          widget.employee?.personal?.fullname ?? "-",
                          maxLines: 1,
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Position
                      Text(
                        widget.employee?.employment?.jobPositionName ?? "-",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 1),

                      // Department
                      Text(
                        widget.employee?.employment?.organizationName ?? "-",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                // Action Button with hover animation
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(
                      alpha: isHovered ? 0.2 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    border: isHovered
                        ? Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: isHovered ? 11 : 10,
                        fontWeight: FontWeight.w600,
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
