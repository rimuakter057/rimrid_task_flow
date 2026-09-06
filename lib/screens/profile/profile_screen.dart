import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_card.dart';
import '../auth/login_screen.dart';
import '../settings/settings_screen.dart';
import '../team/team_members_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = MockData.teamMembers.first;
    final completedTasks = MockData.tasks.where((t) => t.status == TaskStatus.completed).length;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizer.spacing(context, 20),
            vertical: 16,
          ),
          children: [
            Text('Profile', style: AppText.h2),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  AppAvatar(member: currentUser, size: 84),
                  const SizedBox(height: 14),
                  Text(MockData.currentUserName, style: AppText.h2),
                  const SizedBox(height: 4),
                  Text(MockData.currentUserRole, style: AppText.bodyMedium),
                  const SizedBox(height: 2),
                  Text(MockData.currentUserEmail, style: AppText.bodySmall),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _StatBox(value: '${MockData.projects.length}', label: 'Projects')),
                const SizedBox(width: 12),
                Expanded(child: _StatBox(value: '$completedTasks', label: 'Completed')),
                const SizedBox(width: 12),
                Expanded(child: _StatBox(value: '${MockData.teamMembers.length}', label: 'Teammates')),
              ],
            ),
            const SizedBox(height: 28),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _MenuTile(
                    icon: Icons.group_outlined,
                    label: 'Team Members',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TeamMembersScreen()),
                    ),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _MenuTile(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _MenuTile(icon: Icons.help_outline_rounded, label: 'Help & Support', onTap: () {}),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _MenuTile(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    iconColor: AppColors.error,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(value, style: AppText.h3),
          const SizedBox(height: 2),
          Text(label, style: AppText.bodySmall),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w500))),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
