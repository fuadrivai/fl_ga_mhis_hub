import 'package:fl_ga_mhis_hub/library/common.dart';
import 'package:fl_ga_mhis_hub/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatelessWidget {
  final VoidCallback? onPressedSettings;

  const CustomAppbar({super.key, this.onPressedSettings});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 640;
    final isExtraSmallScreen = width < 420;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isExtraSmallScreen ? 12 : (isSmallScreen ? 16 : 24),
            vertical: 16,
          ),
          child: isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(
                      context,
                      isSmallScreen,
                      isExtraSmallScreen,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildDateSection(
                            context,
                            isSmallScreen,
                            isExtraSmallScreen,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildSettingButton(context, isExtraSmallScreen),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildTitleSection(
                        context,
                        isSmallScreen,
                        isExtraSmallScreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildDateSection(
                      context,
                      isSmallScreen,
                      isExtraSmallScreen,
                    ),
                    const SizedBox(width: 10),
                    _buildSettingButton(context, isExtraSmallScreen),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(
    BuildContext context,
    bool isSmallScreen,
    bool isExtraSmallScreen,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.schedule_rounded,
          color: const Color(0xFF4F46E5),
          size: isExtraSmallScreen ? 22 : (isSmallScreen ? 24 : 28),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            'Absensi OB & Security',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isExtraSmallScreen ? 18 : (isSmallScreen ? 20 : 24),
              fontWeight: FontWeight.w700,
              color: Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    bool isSmallScreen,
    bool isExtraSmallScreen,
  ) {
    return Container(
      width: isSmallScreen ? double.infinity : null,
      padding: EdgeInsets.symmetric(
        horizontal: isExtraSmallScreen ? 10 : 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: isExtraSmallScreen ? 15 : 18,
            color: Colors.grey[600],
          ),
          Text(
            Common.getCurrentDate(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: isExtraSmallScreen ? 14 : (isSmallScreen ? 16 : 20),
              color: Colors.grey[700],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: RealtimeClock(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingButton(BuildContext context, bool isExtraSmallScreen) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressedSettings,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isExtraSmallScreen ? 9 : 10),
          child: FaIcon(
            FontAwesomeIcons.gear,
            color: Colors.white,
            size: isExtraSmallScreen ? 18 : 20,
          ),
        ),
      ),
    );
  }
}
