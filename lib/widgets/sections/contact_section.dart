import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;

  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.contactTitle,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 20),
          Text(
            AppStrings.contactDescription,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.white70,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 15 : 30,
            runSpacing: 20,
            children: [
              _buildContactButton(
                icon: FontAwesomeIcons.envelope,
                label: AppStrings.emailLabel,
                url: AppUrls.email,
              ),
              _buildContactButton(
                icon: FontAwesomeIcons.linkedin,
                label: AppStrings.linkedinLabel,
                url: AppUrls.linkedin,
              ),
              _buildContactButton(
                icon: FontAwesomeIcons.github,
                label: AppStrings.githubLabel,
                url: AppUrls.github,
              ),
              _buildContactButton(
                icon: FontAwesomeIcons.whatsapp,
                label: AppStrings.whatsappLabel,
                url: AppUrls.whatsapp,
              ),
            ],
          ),
          const SizedBox(height: 60),
          Divider(color: AppColors.white.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            AppStrings.copyright,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 12 : 14,
              color: AppColors.white70,
            ),
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

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 30,
          vertical: isMobile ? 15 : 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, color: AppColors.white, size: isMobile ? 18 : 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
