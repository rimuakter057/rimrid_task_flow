import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_progress_indicator.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/task_card.dart';
import '../tasks/create_edit_task_screen.dart';
import '../tasks/task_details_screen.dart';
import '../team/team_members_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;
  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  // Which section tab is currently shown: 0 = Tasks, 1 = Team, 2 = Activity.
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final projectTasks = MockData.tasks.where((t) => t.projectName == project.name).toList();
    final todoCount = projectTasks.where((t) => t.status == TaskStatus.toDo).length;
    final inProgressCount = projectTasks.where((t) => t.status == TaskStatus.inProgress).length;
    final completedCount = projectTasks.where((t) => t.status == TaskStatus.completed).length;

    return Scaffold(
      appBar: AppDetailHeader(
        title: project.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.group_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => TeamMembersScreen(members: project.members)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CreateEditTaskScreen(projectName: project.name)),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: project.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(project.icon, color: project.color, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(project.name, style: AppText.h3)),
                      StatusBadge(
                        label: project.status.label,
                        color: project.status.color,
                        backgroundColor: project.status.bgColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(project.description, style: AppText.bodyMedium),
                  const SizedBox(height: 18),
                  AppProgressIndicator(progress: project.progress, color: project.color, showLabel: true),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.event_rounded, size: 16, color: AppColors.textHint),
                      const SizedBox(width: 6),
                      Text('Due ${project.deadline}', style: AppText.bodySmall),
                      const Spacer(),
                      AvatarStack(members: project.members),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: _StatBox(label: 'To Do', value: '$todoCount', color: AppColors.textSecondary)),
                const SizedBox(width: 10),
                Expanded(child: _StatBox(label: 'In Progress', value: '$inProgressCount', color: AppColors.info)),
                const SizedBox(width: 10),
                Expanded(child: _StatBox(label: 'Done', value: '$completedCount', color: AppColors.success)),
              ],
            ),
            const SizedBox(height: 22),
            _SegmentedTabs(
              selectedIndex: _selectedTab,
              onChanged: (index) => setState(() => _selectedTab = index),
            ),
            const SizedBox(height: 16),
            if (_selectedTab == 0)
              _TasksTab(project: project, tasks: projectTasks)
            else if (_selectedTab == 1)
              _TeamTab(members: project.members)
            else
              _ActivityTab(),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Text(value, style: AppText.h3.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(label, style: AppText.bodySmall),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const _SegmentedTabs({required this.selectedIndex, required this.onChanged});

  static const _labels = ['Tasks', 'Team', 'Activity'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.border.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          for (int i = 0; i < _labels.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: selectedIndex == i ? AppColors.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: selectedIndex == i
                        ? [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _labels[i],
                    style: AppText.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selectedIndex == i ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TasksTab extends StatelessWidget {
  final Project project;
  final List<Task> tasks;
  const _TasksTab({required this.project, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('No tasks yet.', style: AppText.bodyMedium)),
      );
    }
    return Column(
      children: [
        for (final task in tasks) ...[
          TaskCard(
            task: task,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => TaskDetailsScreen(task: task)),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _TeamTab extends StatelessWidget {
  final List<TeamMember> members;
  const _TeamTab({required this.members});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (int i = 0; i < members.length; i++) ...[
            Row(
              children: [
                AppAvatar(member: members[i], size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(members[i].name, style: AppText.h4),
                      Text(members[i].role, style: AppText.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            if (i != members.length - 1) const Divider(height: 26),
          ],
        ],
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (int i = 0; i < MockData.recentActivity.length; i++) ...[
            _ActivityRow(activity: MockData.recentActivity[i]),
            if (i != MockData.recentActivity.length - 1) const Divider(height: 24),
          ],
        ],
      ),
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
