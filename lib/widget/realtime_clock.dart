import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealtimeClock extends StatelessWidget {
  final Color? color;
  final double? fontSize;
  const RealtimeClock({super.key, this.color, this.fontSize});

  Stream<DateTime> _clockStream() =>
      Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _clockStream(),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final formattedTime = DateFormat('HH:mm:ss').format(now);

        return Text(
          formattedTime,
          style: TextStyle(
            fontSize: fontSize ?? 20,
            color: color ?? Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        );
      },
    );
  }
}
