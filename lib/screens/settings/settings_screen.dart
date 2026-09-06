import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Simple local toggle states, kept with setState.
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _taskReminders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppDetailHeader(title: 'Settings'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _SettingsSectionLabel(label: 'Preferences'),
            const SizedBox(height: 10),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _SwitchTile(
                    icon: Icons.notifications_outlined,
                    label: 'Push Notifications',
                    value: _pushNotifications,
                    onChanged: (value) => setState(() => _pushNotifications = value),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _SwitchTile(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email Notifications',
                    value: _emailNotifications,
                    onChanged: (value) => setState(() => _emailNotifications = value),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _SwitchTile(
                    icon: Icons.alarm_rounded,
                    label: 'Task Reminders',
                    value: _taskReminders,
                    onChanged: (value) => setState(() => _taskReminders = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SettingsSectionLabel(label: 'Account'),
            const SizedBox(height: 10),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _NavTile(icon: Icons.lock_outline_rounded, label: 'Change Password'),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _NavTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy'),
                  const Divider(height: 1, indent: 20, endIndent: 20),
                  _NavTile(icon: Icons.description_outlined, label: 'Terms of Service'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _SettingsSectionLabel(label: 'About'),
            const SizedBox(height: 10),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _NavTile(icon: Icons.info_outline_rounded, label: 'App Version', trailingText: '1.0.0'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSectionLabel extends StatelessWidget {
  final String label;
  const _SettingsSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label.toUpperCase(), style: AppText.caption.copyWith(letterSpacing: 0.6));
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w500))),
          Switch(value: value, onChanged: onChanged, activeThumbColor: AppColors.primary),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailingText;

  const _NavTile({required this.icon, required this.label, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 14),
            Expanded(child: Text(label, style: AppText.bodyLarge.copyWith(fontWeight: FontWeight.w500))),
            if (trailingText != null)
              Text(trailingText!, style: AppText.bodySmall)
            else
              const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
