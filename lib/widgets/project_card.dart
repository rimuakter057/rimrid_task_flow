import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/mock_data.dart';
import 'app_avatar.dart';
import 'app_card.dart';
import 'app_progress_indicator.dart';
import 'status_badge.dart';

/// A card that shows a project's summary: name, status, progress,
/// deadline and team members. Tap it to open the project details.
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({super.key, required this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: project.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(project.icon, color: project.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(project.name, style: AppText.h4, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              StatusBadge(
                label: project.status.label,
                color: project.status.color,
                backgroundColor: project.status.bgColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: AppText.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          AppProgressIndicator(progress: project.progress, color: project.color, showLabel: true),
          const SizedBox(height: 14),
          Row(
            children: [
              AvatarStack(members: project.members),
              const Spacer(),
              Icon(Icons.event_rounded, size: 14, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(project.deadline, style: AppText.caption),
            ],
          ),
        ],
      ),
    );
  }
}
