import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/mock_data.dart';
import 'app_avatar.dart';
import 'app_card.dart';
import 'status_badge.dart';

/// A card that shows a single task's summary: title, project, priority,
/// due date and who it's assigned to. Tap it to open the task details.
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simple checkbox-style status icon.
          Icon(
            isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            color: isCompleted ? AppColors.success : AppColors.textHint,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: AppText.h4.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(task.projectName, style: AppText.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  children: [
                    StatusBadge(
                      label: task.priority.label,
                      color: task.priority.color,
                      backgroundColor: task.priority.bgColor,
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(task.dueDate, style: AppText.caption),
                    const Spacer(),
                    AppAvatar(member: task.assignee, size: 26),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
