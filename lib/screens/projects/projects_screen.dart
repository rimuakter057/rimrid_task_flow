import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_sizer.dart';
import '../../data/mock_data.dart';
import '../../widgets/app_header.dart';
import '../../widgets/project_card.dart';
import 'project_details_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // Which status filter chip is selected. "All" shows every project.
  ProjectStatus? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final filteredProjects = MockData.projects.where((project) {
      final matchesSearch = project.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == null || project.status == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSizer.spacing(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AppHeader(title: 'Projects', subtitle: 'Track progress across all your projects.'),
              const SizedBox(height: 20),
              _SearchBar(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 16),
              _FilterChips(
                selected: _selectedFilter,
                onSelected: (status) => setState(() => _selectedFilter = status),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredProjects.isEmpty
                    ? Center(child: Text('No projects found.', style: AppText.bodyMedium))
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: filteredProjects.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final project = filteredProjects[index];
                          return ProjectCard(
                            project: project,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ProjectDetailsScreen(project: project)),
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

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppText.bodyLarge,
      decoration: const InputDecoration(
        hintText: 'Search projects...',
        prefixIcon: Icon(Icons.search_rounded, color: AppColors.textHint),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final ProjectStatus? selected;
  final ValueChanged<ProjectStatus?> onSelected;
  const _FilterChips({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterChip(label: 'All', isSelected: selected == null, onTap: () => onSelected(null)),
          for (final status in ProjectStatus.values) ...[
            const SizedBox(width: 8),
            _FilterChip(
              label: status.label,
              isSelected: selected == status,
              onTap: () => onSelected(status),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppText.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
