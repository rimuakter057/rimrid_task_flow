import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_text_field.dart';

/// A single screen used for both creating a new task and editing an
/// existing one. If [existingTask] is null we're creating a new task,
/// otherwise we're editing it (the fields are pre-filled).
class CreateEditTaskScreen extends StatefulWidget {
  final String projectName;
  final Task? existingTask;

  const CreateEditTaskScreen({super.key, required this.projectName, this.existingTask});

  @override
  State<CreateEditTaskScreen> createState() => _CreateEditTaskScreenState();
}

class _CreateEditTaskScreenState extends State<CreateEditTaskScreen> {
  late final _titleController = TextEditingController(text: widget.existingTask?.title ?? '');
  late final _descriptionController = TextEditingController(text: widget.existingTask?.description ?? '');

  late TaskPriority _selectedPriority = widget.existingTask?.priority ?? TaskPriority.medium;
  late TaskStatus _selectedStatus = widget.existingTask?.status ?? TaskStatus.toDo;
  late TeamMember _selectedAssignee = widget.existingTask?.assignee ?? MockData.teamMembers.first;
  DateTime _dueDate = DateTime.now().add(const Duration(days: 3));

  bool get _isEditing => widget.existingTask != null;

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDetailHeader(title: _isEditing ? 'Edit Task' : 'Create Task'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            AppTextField(label: 'Task Title', hint: 'Enter task title', controller: _titleController),
            const SizedBox(height: 18),
            AppTextField(
              label: 'Description',
              hint: 'Add more details about this task...',
              controller: _descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 18),
            Text('Project', style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(widget.projectName, style: AppText.bodyLarge),
            ),
            const SizedBox(height: 18),
            Text('Priority', style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                for (final priority in TaskPriority.values) ...[
                  Expanded(
                    child: _SelectableChip(
                      label: priority.label,
                      color: priority.color,
                      isSelected: _selectedPriority == priority,
                      onTap: () => setState(() => _selectedPriority = priority),
                    ),
                  ),
                  if (priority != TaskPriority.values.last) const SizedBox(width: 10),
                ],
              ],
            ),
            const SizedBox(height: 18),
            Text('Status', style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                for (final status in TaskStatus.values) ...[
                  Expanded(
                    child: _SelectableChip(
                      label: status.label,
                      color: status.color,
                      isSelected: _selectedStatus == status,
                      onTap: () => setState(() => _selectedStatus = status),
                    ),
                  ),
                  if (status != TaskStatus.values.last) const SizedBox(width: 10),
                ],
              ],
            ),
            const SizedBox(height: 18),
            Text('Due Date', style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDueDate,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.textHint),
                    const SizedBox(width: 10),
                    Text('${_dueDate.month}/${_dueDate.day}/${_dueDate.year}', style: AppText.bodyLarge),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text('Assign To', style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            SizedBox(
              height: 78,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: MockData.teamMembers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final member = MockData.teamMembers[index];
                  final isSelected = member.id == _selectedAssignee.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAssignee = member),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
                          ),
                          child: AppAvatar(member: member, size: 44),
                        ),
                        const SizedBox(height: 6),
                        Text(member.name.split(' ').first, style: AppText.caption),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            AppButton(
              label: _isEditing ? 'Save Changes' : 'Create Task',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableChip({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.12) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: AppText.bodySmall.copyWith(
            color: isSelected ? color : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
