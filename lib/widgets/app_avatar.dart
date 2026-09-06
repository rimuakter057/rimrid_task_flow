import 'package:flutter/material.dart';
import '../data/mock_data.dart';

/// A small circular avatar that shows a team member's initials on a
/// colored background. Used instead of real profile photos since this
/// app only uses mock data.
class AppAvatar extends StatelessWidget {
  final TeamMember member;
  final double size;
  final bool showBorder;

  const AppAvatar({
    super.key,
    required this.member,
    this.size = 36,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: member.avatarColor,
        shape: BoxShape.circle,
        border: showBorder ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Text(
        member.initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: size * 0.38,
        ),
      ),
    );
  }
}

/// Shows a row of overlapping avatars (e.g. project team members) with a
/// "+N" bubble when there are more members than [maxVisible].
class AvatarStack extends StatelessWidget {
  final List<TeamMember> members;
  final int maxVisible;
  final double size;

  const AvatarStack({
    super.key,
    required this.members,
    this.maxVisible = 3,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    final visibleMembers = members.take(maxVisible).toList();
    final remaining = members.length - visibleMembers.length;

    return SizedBox(
      height: size,
      width: (visibleMembers.length + (remaining > 0 ? 1 : 0)) * size * 0.7 + size * 0.3,
      child: Stack(
        children: [
          for (int i = 0; i < visibleMembers.length; i++)
            Positioned(
              left: i * size * 0.7,
              child: AppAvatar(member: visibleMembers[i], size: size, showBorder: true),
            ),
          if (remaining > 0)
            Positioned(
              left: visibleMembers.length * size * 0.7,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  '+$remaining',
                  style: TextStyle(fontSize: size * 0.32, fontWeight: FontWeight.w700, color: Colors.black87),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
