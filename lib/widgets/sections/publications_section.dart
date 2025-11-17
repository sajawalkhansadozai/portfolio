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
  int? _hoveredBookIndex;
  int? _hoveredButtonIndex;

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
          widget.isMobile
              ? Column(
                  children: [
                    _buildBookCard(
                      title: AppStrings.book1Title,
                      subtitle: AppStrings.book1Subtitle,
                      author: AppStrings.book1Author,
                      description: AppStrings.book1Description,
                      buttonLabel: AppStrings.viewOnAmazon,
                      url: AppUrls.book1Amazon,
                      gradientColors: [
                        const Color(0xFFDC143C),
                        const Color(0xFF8B0000),
                      ],
                      index: 0,
                    ),
                    const SizedBox(height: 40),
                    _buildBookCard(
                      title: AppStrings.book2Title,
                      subtitle: AppStrings.book2Subtitle,
                      author: AppStrings.book2Author,
                      description: AppStrings.book2Description,
                      buttonLabel: AppStrings.downloadPDF,
                      url: AppUrls.book2GitHub,
                      gradientColors: [
                        const Color(0xFF2E3192),
                        const Color(0xFF1E2272),
                      ],
                      index: 1,
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildBookCard(
                        title: AppStrings.book1Title,
                        subtitle: AppStrings.book1Subtitle,
                        author: AppStrings.book1Author,
                        description: AppStrings.book1Description,
                        buttonLabel: AppStrings.viewOnAmazon,
                        url: AppUrls.book1Amazon,
                        gradientColors: [
                          const Color(0xFFDC143C),
                          const Color(0xFF8B0000),
                        ],
                        index: 0,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _buildBookCard(
                        title: AppStrings.book2Title,
                        subtitle: AppStrings.book2Subtitle,
                        author: AppStrings.book2Author,
                        description: AppStrings.book2Description,
                        buttonLabel: AppStrings.downloadPDF,
                        url: AppUrls.book2GitHub,
                        gradientColors: [
                          const Color(0xFF2E3192),
                          const Color(0xFF1E2272),
                        ],
                        index: 1,
                      ),
                    ),
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
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBookCard({
    required String title,
    required String subtitle,
    required String author,
    required String description,
    required String buttonLabel,
    required String url,
    required List<Color> gradientColors,
    required int index,
  }) {
    final bool isHovering = _hoveredBookIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredBookIndex = index),
      onExit: (_) => setState(() => _hoveredBookIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovering ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isHovering
                ? AppColors.primary.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovering
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.black.withOpacity(0.1),
              blurRadius: isHovering ? 30 : 20,
              offset: Offset(0, isHovering ? 15 : 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.isMobile ? 25 : 35),
          child: Column(
            children: [
              _buildBookCover(gradientColors, title, subtitle),
              const SizedBox(height: 30),
              _buildBookInfo(
                title,
                subtitle,
                author,
                description,
                buttonLabel,
                url,
                index,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCover(
    List<Color> gradientColors,
    String title,
    String subtitle,
  ) {
    // Check if this is "After Humanity" book for custom green cover
    final bool isAfterHumanity = title.contains('After Humanity');

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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isAfterHumanity
                    ? [const Color(0xFF7FA650), const Color(0xFF5A7A3C)]
                    : gradientColors,
              ),
            ),
            child: isAfterHumanity
                ? _buildAfterHumanityCover(title, subtitle)
                : _buildSilentSufferingCover(),
          ),
        ),
      ),
    );
  }

  Widget _buildAfterHumanityCover(String title, String subtitle) {
    return Stack(
      children: [
        // Geometric pattern background
        Positioned.fill(child: CustomPaint(painter: GeometricPatternPainter())),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.replaceAll('After Humanity', 'After Humanity:'),
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.95),
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Container(
                height: 2,
                width: 60,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(height: 15),
              Text(
                'Sajawal Khan Sadozai',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSilentSufferingCover() {
    return Stack(
      children: [
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
    );
  }

  Widget _buildBookInfo(
    String title,
    String subtitle,
    String author,
    String description,
    String buttonLabel,
    String url,
    int bookIndex,
  ) {
    final bool isButtonHovered = _hoveredButtonIndex == bookIndex;

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
          title,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 24 : 30,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 14 : 18,
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
              author,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 14 : 16,
                color: AppColors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 13 : 15,
            color: AppColors.black87,
            height: 1.8,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 30),
        MouseRegion(
          onEnter: (_) => setState(() => _hoveredButtonIndex = bookIndex),
          onExit: (_) => setState(() => _hoveredButtonIndex = null),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..scale(isButtonHovered ? 1.05 : 1.0),
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(url),
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
                elevation: isButtonHovered ? 8 : 3,
                shadowColor: AppColors.primary.withOpacity(0.5),
              ),
              icon: FaIcon(
                buttonLabel.contains('Amazon')
                    ? FontAwesomeIcons.amazon
                    : FontAwesomeIcons.download,
                size: 20,
              ),
              label: Text(
                buttonLabel,
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

// Custom painter for geometric pattern on After Humanity cover
class GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw diagonal lines
    for (double i = -size.height; i < size.width + size.height; i += 40) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
