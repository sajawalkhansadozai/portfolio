import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';

class PublicationsSection extends StatefulWidget {
  final bool isMobile;

  const PublicationsSection({super.key, required this.isMobile});

  @override
  State<PublicationsSection> createState() => _PublicationsSectionState();
}

class _PublicationsSectionState extends State<PublicationsSection> {
  bool _isBookHovering = false;
  bool _isButtonHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 100,
        vertical: widget.isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.publicationsTitle,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 50),
          _buildBookCard(),
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

  Widget _buildBookCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isBookHovering = true),
      onExit: (_) => setState(() => _isBookHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isBookHovering ? 1.02 : 1.0),
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: widget.isMobile ? double.infinity : 1000,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isBookHovering
                ? AppColors.primary.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isBookHovering
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.black.withOpacity(0.1),
              blurRadius: _isBookHovering ? 30 : 20,
              offset: Offset(0, _isBookHovering ? 15 : 10),
            ),
          ],
        ),
        child: widget.isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          _buildBookCover(),
          const SizedBox(height: 35),
          _buildBookInfo(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: _buildBookCover()),
          const SizedBox(width: 70),
          Expanded(flex: 3, child: _buildBookInfo()),
        ],
      ),
    );
  }

  Widget _buildBookCover() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFFDC143C), const Color(0xFF8B0000)],
              ),
            ),
            child: Stack(
              children: [
                // Decorative circular patterns
                Positioned(
                  left: -50,
                  top: 50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 40,
                      ),
                    ),
                  ),
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sajawal Khan',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'The unseen\nbattle of\nHuman rights',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Silent\nSuffering',
                        style: GoogleFonts.poppins(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_stories,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.publishedLabel,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.bookTitle,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.bookSubtitle,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 16 : 20,
            color: Colors.grey[700],
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.person, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              AppStrings.bookAuthor,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 14 : 16,
                color: AppColors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          AppStrings.bookDescription,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 14 : 16,
            color: AppColors.black87,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 40),
        MouseRegion(
          onEnter: (_) => setState(() => _isButtonHovering = true),
          onExit: (_) => setState(() => _isButtonHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..scale(_isButtonHovering ? 1.05 : 1.0),
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(AppUrls.amazonBook),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 25 : 35,
                  vertical: widget.isMobile ? 15 : 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: _isButtonHovering ? 8 : 3,
                shadowColor: AppColors.primary.withOpacity(0.5),
              ),
              icon: const FaIcon(FontAwesomeIcons.amazon, size: 20),
              label: Text(
                AppStrings.viewOnAmazon,
                style: GoogleFonts.poppins(
                  fontSize: widget.isMobile ? 14 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildTag('Human Rights'),
            _buildTag('Social Justice'),
            _buildTag('Non-Fiction'),
            _buildTag('Activism'),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
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
