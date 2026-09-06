import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// A reusable header shown at the top of the main tab screens
/// (Dashboard, Projects, etc). Shows a title/greeting and an optional
/// notification bell + avatar on the right.
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onNotificationTap;
  final Widget? trailing;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onNotificationTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.h2),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: AppText.bodyMedium),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
        if (trailing == null && onNotificationTap != null)
          _NotificationButton(onTap: onNotificationTap!),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NotificationButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
            Positioned(
              top: 10,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple top bar for inner/detail screens: back button + title + optional actions.
class AppDetailHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppDetailHeader({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
