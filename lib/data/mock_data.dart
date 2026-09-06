import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// This file holds simple mock/static data models and lists.
/// In a real app these would come from a backend/database.
/// Everything here is plain Dart - no external state management.

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

enum TaskPriority { low, medium, high }

enum TaskStatus { toDo, inProgress, completed }

enum ProjectStatus { active, onHold, completed }

extension TaskPriorityX on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.low:
        return AppColors.info;
      case TaskPriority.medium:
        return AppColors.warning;
      case TaskPriority.high:
        return AppColors.error;
    }
  }

  Color get bgColor {
    switch (this) {
      case TaskPriority.low:
        return AppColors.infoBg;
      case TaskPriority.medium:
        return AppColors.warningBg;
      case TaskPriority.high:
        return AppColors.errorBg;
    }
  }
}

extension TaskStatusX on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.toDo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.toDo:
        return AppColors.textSecondary;
      case TaskStatus.inProgress:
        return AppColors.info;
      case TaskStatus.completed:
        return AppColors.success;
    }
  }

  Color get bgColor {
    switch (this) {
      case TaskStatus.toDo:
        return AppColors.border;
      case TaskStatus.inProgress:
        return AppColors.infoBg;
      case TaskStatus.completed:
        return AppColors.successBg;
    }
  }
}

extension ProjectStatusX on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.active:
        return 'Active';
      case ProjectStatus.onHold:
        return 'On Hold';
      case ProjectStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case ProjectStatus.active:
        return AppColors.info;
      case ProjectStatus.onHold:
        return AppColors.warning;
      case ProjectStatus.completed:
        return AppColors.success;
    }
  }

  Color get bgColor {
    switch (this) {
      case ProjectStatus.active:
        return AppColors.infoBg;
      case ProjectStatus.onHold:
        return AppColors.warningBg;
      case ProjectStatus.completed:
        return AppColors.successBg;
    }
  }
}

// ---------------------------------------------------------------------------
// Models
// ---------------------------------------------------------------------------

class TeamMember {
  final String id;
  final String name;
  final String role;
  final Color avatarColor;

  const TeamMember({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarColor,
  });

  // Used to show initials instead of a real profile picture.
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}

class TaskComment {
  final String memberName;
  final Color avatarColor;
  final String message;
  final String timeAgo;

  const TaskComment({
    required this.memberName,
    required this.avatarColor,
    required this.message,
    required this.timeAgo,
  });
}

class TaskAttachment {
  final String fileName;
  final String fileSize;
  final IconData icon;

  const TaskAttachment({
    required this.fileName,
    required this.fileSize,
    required this.icon,
  });
}

class Task {
  final String id;
  final String title;
  final String description;
  final String projectName;
  final TaskPriority priority;
  final TaskStatus status;
  final String dueDate;
  final TeamMember assignee;
  final List<TaskComment> comments;
  final List<TaskAttachment> attachments;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.projectName,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.assignee,
    this.comments = const [],
    this.attachments = const [],
  });
}

class Project {
  final String id;
  final String name;
  final String description;
  final ProjectStatus status;
  final double progress; // 0.0 to 1.0
  final String deadline;
  final List<TeamMember> members;
  final int totalTasks;
  final int completedTasks;
  final IconData icon;
  final Color color;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.progress,
    required this.deadline,
    required this.members,
    required this.totalTasks,
    required this.completedTasks,
    required this.icon,
    required this.color,
  });
}

class ActivityItem {
  final String memberName;
  final Color avatarColor;
  final String action;
  final String timeAgo;
  final IconData icon;

  const ActivityItem({
    required this.memberName,
    required this.avatarColor,
    required this.action,
    required this.timeAgo,
    required this.icon,
  });
}

class AppNotification {
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final bool isRead;

  const AppNotification({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    this.isRead = false,
  });
}

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

class MockData {
  MockData._();

  static const currentUserName = 'Alex Johnson';
  static const currentUserRole = 'Product Designer';
  static const currentUserEmail = 'alex.johnson@taskflow.com';

  static const teamMembers = <TeamMember>[
    TeamMember(id: 't1', name: 'Alex Johnson', role: 'Product Designer', avatarColor: AppColors.primary),
    TeamMember(id: 't2', name: 'Maria Chen', role: 'Frontend Developer', avatarColor: AppColors.success),
    TeamMember(id: 't3', name: 'James Carter', role: 'Backend Developer', avatarColor: AppColors.warning),
    TeamMember(id: 't4', name: 'Sara Williams', role: 'UI/UX Designer', avatarColor: AppColors.info),
    TeamMember(id: 't5', name: 'David Kim', role: 'QA Engineer', avatarColor: AppColors.error),
    TeamMember(id: 't6', name: 'Priya Patel', role: 'Project Manager', avatarColor: Color(0xFF00B8D9)),
  ];

  static final projects = <Project>[
    Project(
      id: 'p1',
      name: 'TaskFlow Mobile App',
      description: 'Design and build the mobile app for task and project management.',
      status: ProjectStatus.active,
      progress: 0.68,
      deadline: 'Oct 12, 2026',
      members: teamMembers.sublist(0, 4),
      totalTasks: 24,
      completedTasks: 16,
      icon: Icons.phone_iphone_rounded,
      color: AppColors.primary,
    ),
    Project(
      id: 'p2',
      name: 'Marketing Website',
      description: 'Revamp the public marketing website with new branding.',
      status: ProjectStatus.active,
      progress: 0.42,
      deadline: 'Nov 02, 2026',
      members: teamMembers.sublist(1, 5),
      totalTasks: 18,
      completedTasks: 7,
      icon: Icons.language_rounded,
      color: AppColors.info,
    ),
    Project(
      id: 'p3',
      name: 'Internal Dashboard',
      description: 'Analytics dashboard for the operations team.',
      status: ProjectStatus.onHold,
      progress: 0.25,
      deadline: 'Dec 18, 2026',
      members: teamMembers.sublist(2, 4),
      totalTasks: 12,
      completedTasks: 3,
      icon: Icons.dashboard_rounded,
      color: AppColors.warning,
    ),
    Project(
      id: 'p4',
      name: 'Brand Guidelines',
      description: 'Create a full brand and visual identity guideline.',
      status: ProjectStatus.completed,
      progress: 1.0,
      deadline: 'Aug 30, 2026',
      members: teamMembers.sublist(0, 3),
      totalTasks: 9,
      completedTasks: 9,
      icon: Icons.palette_rounded,
      color: AppColors.success,
    ),
  ];

  static final tasks = <Task>[
    Task(
      id: 'tk1',
      title: 'Design onboarding screens',
      description:
          'Create high-fidelity mockups for the onboarding flow, including welcome, sign up and permission screens. Keep it aligned with the new brand guidelines and make sure states for empty/loading are covered.',
      projectName: 'TaskFlow Mobile App',
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      dueDate: 'Sep 06, 2026',
      assignee: teamMembers[0],
      comments: const [
        TaskComment(memberName: 'Maria Chen', avatarColor: AppColors.success, message: 'Looks great so far! Can we try a lighter background on screen 2?', timeAgo: '2h ago'),
        TaskComment(memberName: 'Priya Patel', avatarColor: Color(0xFF00B8D9), message: 'Agreed with Maria. Otherwise ready to move to dev.', timeAgo: '1h ago'),
      ],
      attachments: const [
        TaskAttachment(fileName: 'onboarding_v2.fig', fileSize: '4.2 MB', icon: Icons.brush_rounded),
        TaskAttachment(fileName: 'flow_notes.pdf', fileSize: '820 KB', icon: Icons.picture_as_pdf_rounded),
      ],
    ),
    Task(
      id: 'tk2',
      title: 'Fix login API error handling',
      description: 'Handle invalid credentials and network errors gracefully with proper messaging.',
      projectName: 'TaskFlow Mobile App',
      priority: TaskPriority.medium,
      status: TaskStatus.toDo,
      dueDate: 'Sep 08, 2026',
      assignee: teamMembers[2],
    ),
    Task(
      id: 'tk3',
      title: 'Write unit tests for auth module',
      description: 'Add coverage for login, signup and password reset flows.',
      projectName: 'TaskFlow Mobile App',
      priority: TaskPriority.low,
      status: TaskStatus.toDo,
      dueDate: 'Sep 10, 2026',
      assignee: teamMembers[4],
    ),
    Task(
      id: 'tk4',
      title: 'Update landing page hero section',
      description: 'Refresh the hero copy and imagery based on the new campaign.',
      projectName: 'Marketing Website',
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
      dueDate: 'Sep 05, 2026',
      assignee: teamMembers[3],
    ),
    Task(
      id: 'tk5',
      title: 'Prepare Q3 analytics report',
      description: 'Summarize key metrics for stakeholder review.',
      projectName: 'Internal Dashboard',
      priority: TaskPriority.high,
      status: TaskStatus.completed,
      dueDate: 'Aug 28, 2026',
      assignee: teamMembers[5],
    ),
    Task(
      id: 'tk6',
      title: 'Review brand color palette',
      description: 'Final review before sign off with the marketing team.',
      projectName: 'Brand Guidelines',
      priority: TaskPriority.low,
      status: TaskStatus.completed,
      dueDate: 'Aug 20, 2026',
      assignee: teamMembers[0],
    ),
  ];

  static const recentActivity = <ActivityItem>[
    ActivityItem(memberName: 'Maria Chen', avatarColor: AppColors.success, action: 'completed task "Update navigation bar"', timeAgo: '10m ago', icon: Icons.check_circle_rounded),
    ActivityItem(memberName: 'James Carter', avatarColor: AppColors.warning, action: 'commented on "Fix login API error handling"', timeAgo: '45m ago', icon: Icons.chat_bubble_rounded),
    ActivityItem(memberName: 'Sara Williams', avatarColor: AppColors.info, action: 'uploaded a new file to "Marketing Website"', timeAgo: '2h ago', icon: Icons.upload_file_rounded),
    ActivityItem(memberName: 'Priya Patel', avatarColor: Color(0xFF00B8D9), action: 'created a new project "Internal Dashboard"', timeAgo: '5h ago', icon: Icons.create_new_folder_rounded),
  ];

  static const notifications = <AppNotification>[
    AppNotification(title: 'Task assigned to you', message: 'Maria assigned "Design onboarding screens" to you.', timeAgo: '10m ago', icon: Icons.assignment_ind_rounded, iconColor: AppColors.primary, isRead: false),
    AppNotification(title: 'New comment', message: 'James commented on "Fix login API error handling".', timeAgo: '45m ago', icon: Icons.chat_bubble_rounded, iconColor: AppColors.info, isRead: false),
    AppNotification(title: 'Deadline approaching', message: '"Update landing page hero section" is due tomorrow.', timeAgo: '3h ago', icon: Icons.alarm_rounded, iconColor: AppColors.warning, isRead: true),
    AppNotification(title: 'Task completed', message: 'Sara marked "Prepare Q3 analytics report" as completed.', timeAgo: '1d ago', icon: Icons.check_circle_rounded, iconColor: AppColors.success, isRead: true),
    AppNotification(title: 'Added to project', message: 'You were added to "Internal Dashboard".', timeAgo: '2d ago', icon: Icons.group_add_rounded, iconColor: AppColors.primary, isRead: true),
  ];
}
