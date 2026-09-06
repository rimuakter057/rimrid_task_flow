import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';

/// Shows the list of team members. If [members] is null, the full
/// company team list is shown (used from the Profile tab); otherwise
/// only the given members are shown (used from a specific project).
class TeamMembersScreen extends StatelessWidget {
  final List<TeamMember>? members;
  const TeamMembersScreen({super.key, this.members});

  @override
  Widget build(BuildContext context) {
    final list = members ?? MockData.teamMembers;

    return Scaffold(
      appBar: const AppDetailHeader(title: 'Team Members'),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final member = list[index];
            return AppCard(
              child: Row(
                children: [
                  AppAvatar(member: member, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(member.name, style: AppText.h4),
                        const SizedBox(height: 2),
                        Text(member.role, style: AppText.bodySmall),
                      ],
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.chat_bubble_outline_rounded, size: 17, color: AppColors.primary),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
