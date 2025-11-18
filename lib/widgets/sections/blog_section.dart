import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../data/blog_data.dart';
import '../../models/blog_model.dart';
import '../../screens/blog_post_page.dart';
import '../../screens/rendering_blog_page.dart';

class BlogSection extends StatefulWidget {
  final bool isMobile;

  const BlogSection({super.key, required this.isMobile});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  int? _hoveredIndex;

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
            'Blog',
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 32 : 42,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 10),
          Text(
            'Thoughts, stories and ideas',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 14 : 16,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 30),
          _buildBlogGrid(),
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
            color: AppColors.primary.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  // Category filter removed as per request; all blogs show by default.

  Widget _buildBlogGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double spacing = 20;

        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 900) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1200) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 3;
        }

        // Use Wrap for flexible height cards
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: blogPosts.map((post) {
            final index = blogPosts.indexOf(post);
            return SizedBox(
              width:
                  (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                  crossAxisCount,
              child: _buildBlogCard(post, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBlogCard(BlogPost post, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        child: InkWell(
          onTap: () {
            // Navigate to blog post page for Flutter challenges article
            if (post.url == '#flutter-challenges') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BlogPostPage(isMobile: widget.isMobile, blogPost: post),
                ),
              );
            } else if (post.url == '#rendering-pipeline') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RenderingBlogPage(
                    isMobile: widget.isMobile,
                    blogPost: post,
                  ),
                ),
              );
            } else {
              _launchUrl(post.url);
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary
                    : AppColors.grey.withOpacity(0.2),
                width: isHovered ? 2.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? AppColors.primary.withOpacity(0.2)
                      : AppColors.grey.withOpacity(0.1),
                  blurRadius: isHovered ? 20 : 10,
                  offset: const Offset(0, 5),
                  spreadRadius: isHovered ? 2 : 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBlogImage(post, isHovered),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBlogMeta(post),
                      const SizedBox(height: 12),
                      Text(
                        post.title,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post.excerpt,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 12 : 14,
                          color: AppColors.grey,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      _buildTags(post),
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

  Widget _buildBlogImage(BlogPost post, bool isHovered) {
    return Container(
      // Reduce image height for a more compact card
      height: widget.isMobile ? 140 : 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          // Background image (use per-post imageUrl)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              post.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isHovered
                    ? [
                        AppColors.accent.withOpacity(0.3),
                        AppColors.accentOrange.withOpacity(0.3),
                      ]
                    : [
                        AppColors.primary.withOpacity(0.2),
                        AppColors.secondary.withOpacity(0.2),
                      ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                post.category,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogMeta(BlogPost post) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.calendar, size: 12, color: AppColors.grey),
        const SizedBox(width: 6),
        Text(
          post.date,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 11 : 12,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(width: 12),
        FaIcon(FontAwesomeIcons.clock, size: 12, color: AppColors.grey),
        const SizedBox(width: 6),
        Text(
          post.readTime,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 11 : 12,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BlogPost post) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: post.tags.take(3).map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.accent.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            tag,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }
}
