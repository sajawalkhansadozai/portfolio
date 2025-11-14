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
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(2),
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered ? AppColors.primary : Colors.grey[300]!,
            width: isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isHovered ? 20 : 10,
              offset: Offset(0, isHovered ? 10 : 5),
            ),
          ],
        ),
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              skill.icon,
              size: widget.isMobile ? 30 : 40,
              color: AppColors.primary,
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
              child: LinearProgressIndicator(
                value: skill.level,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.accent,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
