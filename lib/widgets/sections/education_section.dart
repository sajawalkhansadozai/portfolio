import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constants.dart';

class EducationSection extends StatefulWidget {
  final bool isMobile;

  const EducationSection({super.key, required this.isMobile});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.grey[100]!],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 100,
        vertical: widget.isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.educationTitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 40),
          _buildEducationCard(),
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

  Widget _buildEducationCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isHovering ? 1.02 : 1.0),
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: widget.isMobile ? double.infinity : 850,
        ),
        padding: EdgeInsets.all(widget.isMobile ? 25 : 35),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovering
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(_isHovering ? 0.15 : 0.08),
              blurRadius: _isHovering ? 30 : 20,
              offset: Offset(0, _isHovering ? 12 : 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.school,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.degree,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.field,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 14 : 16,
                          color: AppColors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildInfoChip(Icons.business, AppStrings.institution),
                  const SizedBox(width: 20),
                  _buildInfoChip(Icons.calendar_today, AppStrings.year),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.educationDescription,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 14 : 16,
                color: AppColors.black87,
                height: 1.8,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 13 : 15,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
