import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constants.dart';

class AboutSection extends StatefulWidget {
  final bool isMobile;

  const AboutSection({super.key, required this.isMobile});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isImageHovering = false;

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
            AppStrings.aboutTitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 50),
          widget.isMobile
              ? Column(
                  children: [
                    _buildAboutImage(),
                    const SizedBox(height: 40),
                    _buildAboutText(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildAboutImage()),
                    const SizedBox(width: 80),
                    Expanded(child: _buildAboutText()),
                  ],
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

  Widget _buildAboutImage() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isImageHovering = true),
      onExit: (_) => setState(() => _isImageHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isImageHovering ? 1.05 : 1.0),
        child: Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.2),
                  AppColors.accent.withOpacity(0.2),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: _isImageHovering ? 30 : 20,
                  spreadRadius: _isImageHovering ? 8 : 5,
                ),
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: _isImageHovering ? 40 : 25,
                  spreadRadius: _isImageHovering ? 10 : 6,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.accent.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('👋 ', style: TextStyle(fontSize: 20)),
              Text(
                AppStrings.aboutSubtitle,
                style: GoogleFonts.poppins(
                  fontSize: widget.isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Text(
          AppStrings.aboutDescription1,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 15 : 17,
            color: AppColors.black87,
            height: 1.9,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutDescription2,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 15 : 17,
            color: AppColors.black87,
            height: 1.9,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutDescription3,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 15 : 17,
            color: AppColors.black87,
            height: 1.9,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 35),
        _buildInfoCard(Icons.location_on, AppStrings.locationInfo),
        const SizedBox(height: 12),
        _buildInfoCard(Icons.email, AppStrings.availabilityInfo),
        const SizedBox(height: 12),
        _buildInfoCard(Icons.code, AppStrings.roleInfo),
        const SizedBox(height: 40),
        _buildStatistics(),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: widget.isMobile ? 18 : 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 14 : 16,
                color: AppColors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      padding: EdgeInsets.all(widget.isMobile ? 20 : 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.accent.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: widget.isMobile
          ? Column(
              children: [
                _buildStatCard(
                  AppStrings.yearsOfExperience,
                  AppStrings.yearsLabel,
                ),
                const SizedBox(height: 20),
                _buildStatCard(
                  AppStrings.projectsCompleted,
                  AppStrings.projectsLabel,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  AppStrings.yearsOfExperience,
                  AppStrings.yearsLabel,
                ),
                _buildStatCard(
                  AppStrings.projectsCompleted,
                  AppStrings.projectsLabel,
                ),
              ],
            ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 12 : 14,
            color: AppColors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
