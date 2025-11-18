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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.primaryDark,
          ],
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
              _ContactButton(
                icon: FontAwesomeIcons.envelope,
                label: AppStrings.emailLabel,
                url: AppUrls.email,
                isMobile: isMobile,
              ),
              _ContactButton(
                icon: FontAwesomeIcons.linkedin,
                label: AppStrings.linkedinLabel,
                url: AppUrls.linkedin,
                isMobile: isMobile,
              ),
              _ContactButton(
                icon: FontAwesomeIcons.github,
                label: AppStrings.githubLabel,
                url: AppUrls.github,
                isMobile: isMobile,
              ),
              _ContactButton(
                icon: FontAwesomeIcons.whatsapp,
                label: AppStrings.whatsappLabel,
                url: AppUrls.whatsapp,
                isMobile: isMobile,
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
        gradient: LinearGradient(
          colors: [AppColors.accent, AppColors.accentOrange],
        ),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isMobile;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.isMobile,
  });

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isHovering ? 1.08 : 1.0),
        child: InkWell(
          onTap: () => _launchUrl(widget.url),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 20 : 30,
              vertical: widget.isMobile ? 15 : 20,
            ),
            decoration: BoxDecoration(
              gradient: _isHovering
                  ? LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.2),
                        AppColors.accentOrange.withOpacity(0.2),
                      ],
                    )
                  : null,
              color: _isHovering ? null : AppColors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: _isHovering
                    ? AppColors.accent
                    : AppColors.white.withOpacity(0.3),
                width: _isHovering ? 2 : 1,
              ),
              boxShadow: _isHovering
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.icon,
                  color: AppColors.white,
                  size: widget.isMobile ? 18 : 20,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    fontSize: widget.isMobile ? 14 : 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
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
