import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Keeps a local copy so tapping a notification can mark it as read
  // using setState, without needing a state management package.
  late final List<AppNotification> _notifications = List.of(MockData.notifications);

  @override
  Widget build(BuildContext context) {
    final hasUnread = _notifications.any((n) => !n.isRead);
    // This screen is used both as a bottom-nav tab (nothing to pop) and
    // as a screen pushed from the dashboard bell icon (can pop back).
    final canGoBack = Navigator.of(context).canPop();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSizer.spacing(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if (canGoBack)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                ),
              AppHeader(
                title: 'Notifications',
                trailing: hasUnread
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            for (var i = 0; i < _notifications.length; i++) {
                              _notifications[i] = AppNotification(
                                title: _notifications[i].title,
                                message: _notifications[i].message,
                                timeAgo: _notifications[i].timeAgo,
                                icon: _notifications[i].icon,
                                iconColor: _notifications[i].iconColor,
                                isRead: true,
                              );
                            }
                          });
                        },
                        child: const Text('Mark all read'),
                      )
                    : null,
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return AppCard(
                      color: notification.isRead ? AppColors.surface : AppColors.primaryLight.withValues(alpha: 0.4),
                      onTap: () {
                        setState(() {
                          _notifications[index] = AppNotification(
                            title: notification.title,
                            message: notification.message,
                            timeAgo: notification.timeAgo,
                            icon: notification.icon,
                            iconColor: notification.iconColor,
                            isRead: true,
                          );
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: notification.iconColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(notification.icon, color: notification.iconColor, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.title, style: AppText.h4),
                                const SizedBox(height: 4),
                                Text(notification.message, style: AppText.bodySmall),
                                const SizedBox(height: 6),
                                Text(notification.timeAgo, style: AppText.caption),
                              ],
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 9,
                              height: 9,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
