import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../models/project_model.dart';

class ProjectsSection extends StatefulWidget {
  final bool isMobile;

  const ProjectsSection({super.key, required this.isMobile});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int? _hoveredProjectIndex;
  int? _hoveredButtonIndex;
  String? _hoveredButtonType; // 'live' or 'github'

  final List<ProjectModel> projects = ProjectModel.getProjects();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 100,
        vertical: widget.isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.projectsTitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 20),
          Text(
            AppStrings.projectsSubtitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 14 : 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          _buildProjectsGrid(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive columns based on width
        int crossAxisCount;
        double spacing;

        if (constraints.maxWidth < 600) {
          // Mobile: 1 column
          crossAxisCount = 1;
          spacing = 20;
        } else if (constraints.maxWidth < 900) {
          // Tablet: 2 columns
          crossAxisCount = 2;
          spacing = 20;
        } else if (constraints.maxWidth < 1200) {
          // Small Desktop: 2 columns
          crossAxisCount = 2;
          spacing = 24;
        } else {
          // Large Desktop: 3 columns
          crossAxisCount = 3;
          spacing = 24;
        }

        // Use Wrap for flexible height cards
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: projects.map((project) {
            final index = projects.indexOf(project);
            return SizedBox(
              width:
                  (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                  crossAxisCount,
              child: _buildProjectCard(project, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildProjectCard(ProjectModel project, int index) {
    final bool isHovering = _hoveredProjectIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredProjectIndex = index),
      onExit: (_) => setState(() => _hoveredProjectIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovering ? 1.02 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
            boxShadow: [
              BoxShadow(
                color: isHovering
                    ? Colors.black.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                blurRadius: isHovering ? 15 : 8,
                offset: Offset(0, isHovering ? 6 : 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient header bar
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: project.gradientColors),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      project.title,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Subtitle with gradient color
                    Text(
                      project.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 12 : 13,
                        color: project.gradientColors[0],
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),

                    // Description
                    Text(
                      project.description,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 11 : 12,
                        color: AppColors.grey,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    // Year badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: project.gradientColors[0].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '2024',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: project.gradientColors[0],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Key Services Section
                    Text(
                      'Key Services',
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 11 : 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Services list
                    ...project.techStack
                        .take(3)
                        .map(
                          (tech) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: project.gradientColors[0],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    tech,
                                    style: GoogleFonts.poppins(
                                      fontSize: widget.isMobile ? 10 : 11,
                                      color: AppColors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    const SizedBox(height: 16),

                    // Visit Website Button
                    SizedBox(
                      width: double.infinity,
                      child: _buildButton(
                        label: 'Visit Website',
                        icon: Icons.arrow_forward,
                        url: project.liveUrl ?? '',
                        index: index,
                        type: 'live',
                        isPrimary: true,
                        gradientColors: project.gradientColors,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required String url,
    required int index,
    required String type,
    required bool isPrimary,
    required List<Color> gradientColors,
  }) {
    final bool isHovering =
        _hoveredButtonIndex == index && _hoveredButtonType == type;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _hoveredButtonIndex = index;
        _hoveredButtonType = type;
      }),
      onExit: (_) => setState(() {
        _hoveredButtonIndex = null;
        _hoveredButtonType = null;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 12 : 16,
              vertical: widget.isMobile ? 8 : 10,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(8),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: widget.isMobile ? 12 : 14,
                  color: AppColors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: widget.isMobile ? 11 : 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }
}
