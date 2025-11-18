import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/app_constants.dart';
import '../../models/skill_model.dart';

class SkillsSection extends StatefulWidget {
  final bool isMobile;

  const SkillsSection({super.key, required this.isMobile});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final skills = SkillModel.getSkills();

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
            AppStrings.skillsTitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.isMobile ? 2 : 4,
              crossAxisSpacing: widget.isMobile ? 20 : 30,
              mainAxisSpacing: widget.isMobile ? 20 : 30,
              childAspectRatio: widget.isMobile ? 1.1 : 1.05,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return _buildSkillCard(skills[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 80,
      height: 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.accent]),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(SkillModel skill, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(widget.isMobile ? 15 : 20),
        decoration: BoxDecoration(
          gradient: isHovered
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.05),
                    AppColors.accent.withOpacity(0.05),
                  ],
                )
              : null,
          color: isHovered ? null : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered ? AppColors.primary : Colors.grey[300]!,
            width: isHovered ? 2.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 25 : 10,
              offset: Offset(0, isHovered ? 12 : 5),
              spreadRadius: isHovered ? 2 : 0,
            ),
          ],
        ),
        transform: Matrix4.identity()..scale(isHovered ? 1.08 : 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isHovered
                      ? [AppColors.primary, AppColors.secondary]
                      : [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.accent.withOpacity(0.1),
                        ],
                ),
              ),
              child: FaIcon(
                skill.icon,
                size: widget.isMobile ? 28 : 36,
                color: isHovered ? AppColors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              skill.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 12 : 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black87,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: skill.level,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
