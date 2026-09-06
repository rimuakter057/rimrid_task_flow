import 'package:flutter/material.dart';
import '../core/constants/app_text_styles.dart';

/// A small colored pill used to show a status or priority label,
/// e.g. "In Progress", "High", "Completed".
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppText.caption.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
