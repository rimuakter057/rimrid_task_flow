import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/status_badge.dart';
import 'create_edit_task_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _commentController = TextEditingController();

  // Local, in-memory list of comments so a beginner can see how a new
  // comment shows up on screen after being "posted". Not saved anywhere.
  late final List<TaskComment> _comments = List.of(widget.task.comments);

  void _postComment() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      _comments.add(
        TaskComment(
          memberName: MockData.currentUserName,
          avatarColor: AppColors.primary,
          message: _commentController.text.trim(),
          timeAgo: 'Just now',
        ),
      );
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      appBar: AppDetailHeader(
        title: 'Task Details',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CreateEditTaskScreen(projectName: task.projectName, existingTask: task),
              ),
            ),
          ),
        ],
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
                      StatusBadge(label: task.priority.label, color: task.priority.color, backgroundColor: task.priority.bgColor),
                      const SizedBox(width: 8),
                      StatusBadge(label: task.status.label, color: task.status.color, backgroundColor: task.status.bgColor),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(task.title, style: AppText.h2),
                  const SizedBox(height: 6),
                  Text(task.projectName, style: AppText.bodyMedium),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text('Description', style: AppText.h4),
                  const SizedBox(height: 8),
                  Text(task.description, style: AppText.bodyLarge.copyWith(height: 1.5)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _InfoTile(icon: Icons.calendar_today_rounded, label: 'Due Date', value: task.dueDate),
                      ),
                      Expanded(
                        child: _InfoTile(icon: Icons.person_outline_rounded, label: 'Assignee', value: task.assignee.name),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _SectionHeader(title: 'Attachments', count: task.attachments.length),
            const SizedBox(height: 10),
            if (task.attachments.isEmpty)
              _EmptyHint(text: 'No attachments yet.')
            else
              AppCard(
                child: Column(
                  children: [
                    for (int i = 0; i < task.attachments.length; i++) ...[
                      _AttachmentRow(attachment: task.attachments[i]),
                      if (i != task.attachments.length - 1) const Divider(height: 22),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 18),
            _SectionHeader(title: 'Comments', count: _comments.length),
            const SizedBox(height: 10),
            if (_comments.isEmpty)
              _EmptyHint(text: 'No comments yet. Be the first to comment.')
            else
              AppCard(
                child: Column(
                  children: [
                    for (int i = 0; i < _comments.length; i++) ...[
                      _CommentRow(comment: _comments[i]),
                      if (i != _comments.length - 1) const Divider(height: 22),
                    ],
                  ],
                ),
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: AppText.bodyMedium.copyWith(color: AppColors.textPrimary),
                    decoration: const InputDecoration(hintText: 'Write a comment...'),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: _postComment,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppText.caption),
              Text(value, style: AppText.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppText.h4),
        const SizedBox(width: 8),
        Text('($count)', style: AppText.bodySmall),
      ],
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final String text;
  const _EmptyHint({required this.text});

  @override
  Widget build(BuildContext context) {
    return AppCard(child: Text(text, style: AppText.bodySmall));
  }
}

class _AttachmentRow extends StatelessWidget {
  final TaskAttachment attachment;
  const _AttachmentRow({required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.infoBg, borderRadius: BorderRadius.circular(10)),
          child: Icon(attachment.icon, size: 18, color: AppColors.info),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attachment.fileName, style: AppText.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              Text(attachment.fileSize, style: AppText.caption),
            ],
          ),
        ),
        const Icon(Icons.download_rounded, size: 18, color: AppColors.textHint),
      ],
    );
  }
}

class _CommentRow extends StatelessWidget {
  final TaskComment comment;
  const _CommentRow({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(
          member: TeamMember(id: '', name: comment.memberName, role: '', avatarColor: comment.avatarColor),
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(comment.memberName, style: AppText.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Text(comment.timeAgo, style: AppText.caption),
                ],
              ),
              const SizedBox(height: 4),
              Text(comment.message, style: AppText.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
