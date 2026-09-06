import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// A rounded linear progress bar with an optional percentage label.
/// Used for project progress and task completion stats.
class AppProgressIndicator extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color color;
  final Color backgroundColor;
  final double height;
  final bool showLabel;

  const AppProgressIndicator({
    super.key,
    required this.progress,
    this.color = AppColors.primary,
    this.backgroundColor = AppColors.primaryLight,
    this.height = 8,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final percentText = '${(progress * 100).round()}%';

    final bar = ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        minHeight: height,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );

    if (!showLabel) return bar;

    return Row(
      children: [
        Expanded(child: bar),
        const SizedBox(width: 10),
        Text(percentText, style: AppText.bodySmall.copyWith(fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}
