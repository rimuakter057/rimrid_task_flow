import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// A single item shown in the [AppBottomNavBar].
class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const NavItem({required this.icon, required this.activeIcon, required this.label});
}

/// A reusable bottom navigation bar. The parent screen owns the
/// selected index (using setState) and passes it in here along with
/// a callback for when the user taps a different tab.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const items = [
    NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    NavItem(icon: Icons.folder_outlined, activeIcon: Icons.folder_rounded, label: 'Projects'),
    NavItem(icon: Icons.notifications_none_rounded, activeIcon: Icons.notifications_rounded, label: 'Alerts'),
    NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < items.length; i++)
                _NavBarButton(
                  item: items[i],
                  isSelected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarButton({required this.item, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textHint;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? item.activeIcon : item.icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(item.label, style: AppText.caption.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
