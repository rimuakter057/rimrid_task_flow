import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'dashboard/dashboard_screen.dart';
import 'notifications/notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'projects/projects_screen.dart';

/// The main shell of the app after login. It hosts the bottom navigation
/// bar and swaps between the 4 main tabs. The selected tab index is kept
/// with plain setState - no state management package needed here.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Each tab's screen. IndexedStack keeps all of them alive so switching
  // tabs doesn't lose scroll position or rebuild everything from scratch.
  final _tabs = const [
    DashboardScreen(),
    ProjectsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
