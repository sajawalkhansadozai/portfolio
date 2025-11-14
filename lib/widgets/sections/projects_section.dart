import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    if (widget.isMobile) {
      return Column(
        children: projects
            .asMap()
            .entries
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: _buildProjectCard(entry.value, entry.key),
              ),
            )
            .toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 1.05,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return _buildProjectCard(projects[index], index);
        },
      );
    }
  }

  Widget _buildProjectCard(ProjectModel project, int index) {
    final bool isHovering = _hoveredProjectIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredProjectIndex = index),
      onExit: (_) => setState(() => _hoveredProjectIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovering ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isHovering
                ? AppColors.primary.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovering
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.black.withOpacity(0.08),
              blurRadius: isHovering ? 30 : 20,
              offset: Offset(0, isHovering ? 15 : 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectImage(project),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryTag(project.category),
                  const SizedBox(height: 15),
                  Text(
                    project.title,
                    style: GoogleFonts.poppins(
                      fontSize: widget.isMobile ? 22 : 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: widget.isMobile ? 14 : 16,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    project.description,
                    style: GoogleFonts.poppins(
                      fontSize: widget.isMobile ? 13 : 14,
                      color: AppColors.black87,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildTechStack(project.techStack),
                  const SizedBox(height: 30),
                  _buildActionButtons(project, index),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage(ProjectModel project) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(23),
        topRight: Radius.circular(23),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: project.gradientColors,
            ),
          ),
          child: Stack(
            children: [
              // Decorative elements
              Positioned(
                right: -50,
                top: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 40,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                bottom: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                      width: 25,
                    ),
                  ),
                ),
              ),
              // Project icon/title
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.code,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      project.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildCategoryTag(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.category, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            category,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStack(List<String> techStack) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: techStack.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tech,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons(ProjectModel project, int index) {
    return Row(
      children: [
        if (project.liveUrl != null) ...[
          Expanded(
            child: _buildButton(
              label: 'Live Demo',
              icon: Icons.launch,
              url: project.liveUrl!,
              index: index,
              type: 'live',
              isPrimary: true,
            ),
          ),
          if (project.githubUrl != null) const SizedBox(width: 12),
        ],
        if (project.githubUrl != null)
          Expanded(
            child: _buildButton(
              label: 'GitHub',
              icon: FontAwesomeIcons.github,
              url: project.githubUrl!,
              index: index,
              type: 'github',
              isPrimary: project.liveUrl == null,
            ),
          ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required String url,
    required int index,
    required String type,
    required bool isPrimary,
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
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovering ? 1.05 : 1.0),
        child: ElevatedButton.icon(
          onPressed: () => _launchUrl(url),
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? AppColors.primary : Colors.grey[800],
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 16 : 20,
              vertical: widget.isMobile ? 12 : 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: isHovering ? 8 : 3,
            shadowColor: (isPrimary ? AppColors.primary : Colors.grey[800]!)
                .withOpacity(0.5),
          ),
          icon: Icon(icon, size: widget.isMobile ? 14 : 16),
          label: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 12 : 14,
              fontWeight: FontWeight.bold,
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
