import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_progress_indicator.dart';
import '../../widgets/task_card.dart';
import '../notifications/notifications_screen.dart';
import '../projects/project_details_screen.dart';
import '../tasks/task_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeProjects = MockData.projects.where((p) => p.status != ProjectStatus.completed).toList();
    final upcomingTasks = MockData.tasks.where((t) => t.status != TaskStatus.completed).take(4).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.spacing(context, 20),
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(
                title: 'Hi, ${MockData.currentUserName.split(' ').first} 👋',
                subtitle: "Here's what's happening today.",
                onNotificationTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                  );
                },
              ),
              const SizedBox(height: 24),
              _StatRow(),
              const SizedBox(height: 28),
              _SectionTitle(title: 'Project Progress'),
              const SizedBox(height: 14),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: activeProjects.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final project = activeProjects[index];
                    return _ProjectProgressCard(
                      project: project,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProjectDetailsScreen(project: project)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              _SectionTitle(title: 'Recent Tasks'),
              const SizedBox(height: 14),
              for (final task in upcomingTasks) ...[
                TaskCard(
                  task: task,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => TaskDetailsScreen(task: task)),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 14),
              _SectionTitle(title: 'Upcoming Deadlines'),
              const SizedBox(height: 14),
              AppCard(
                child: Column(
                  children: [
                    for (int i = 0; i < 3; i++) ...[
                      _DeadlineRow(project: MockData.projects[i]),
                      if (i != 2) const Divider(height: 20),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _SectionTitle(title: 'Recent Activity'),
              const SizedBox(height: 14),
              AppCard(
                child: Column(
                  children: [
                    for (int i = 0; i < MockData.recentActivity.length; i++) ...[
                      _ActivityRow(activity: MockData.recentActivity[i]),
                      if (i != MockData.recentActivity.length - 1) const Divider(height: 24),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppText.h3);
  }
}

/// Row of overview/stat cards: total projects, tasks done, in progress etc.
class _StatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalTasks = MockData.tasks.length;
    final completedTasks = MockData.tasks.where((t) => t.status == TaskStatus.completed).length;
    final inProgress = MockData.tasks.where((t) => t.status == TaskStatus.inProgress).length;

    final stats = [
      _StatData('Projects', '${MockData.projects.length}', Icons.folder_rounded, AppColors.primary),
      _StatData('Completed', '$completedTasks/$totalTasks', Icons.check_circle_rounded, AppColors.success),
      _StatData('In Progress', '$inProgress', Icons.autorenew_rounded, AppColors.warning),
    ];

    return Row(
      children: [
        for (int i = 0; i < stats.length; i++) ...[
          Expanded(child: _StatCard(data: stats[i])),
          if (i != stats.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _StatData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  _StatData(this.label, this.value, this.icon, this.color);
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: data.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(data.icon, color: data.color, size: 18),
          ),
          const SizedBox(height: 12),
          Text(data.value, style: AppText.h3),
          const SizedBox(height: 2),
          Text(data.label, style: AppText.bodySmall),
        ],
      ),
    );
  }
}

class _ProjectProgressCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  const _ProjectProgressCard({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: AppCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(project.icon, color: project.color, size: 22),
            const SizedBox(height: 12),
            Text(project.name, style: AppText.h4, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text('${project.completedTasks}/${project.totalTasks} tasks', style: AppText.bodySmall),
            const Spacer(),
            AppProgressIndicator(progress: project.progress, color: project.color),
          ],
        ),
      ),
    );
  }
}

class _DeadlineRow extends StatelessWidget {
  final Project project;
  const _DeadlineRow({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.event_rounded, size: 18, color: project.color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(project.name, style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w500)),
        ),
        Text(project.deadline, style: AppText.bodySmall),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final ActivityItem activity;
  const _ActivityRow({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(
          member: TeamMember(id: '', name: activity.memberName, role: '', avatarColor: activity.avatarColor),
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppText.bodyMedium.copyWith(color: AppColors.textPrimary),
              children: [
                TextSpan(text: '${activity.memberName} ', style: const TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: activity.action),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(activity.timeAgo, style: AppText.caption),
      ],
    );
  }
}
