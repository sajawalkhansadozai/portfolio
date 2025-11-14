import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constants.dart';

class AchievementsSection extends StatefulWidget {
  final bool isMobile;

  const AchievementsSection({super.key, required this.isMobile});

  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        'icon': Icons.book,
        'title': AppStrings.achievement1,
        'color': const Color(0xFF6366F1),
      },
      {
        'icon': Icons.web,
        'title': AppStrings.achievement2,
        'color': const Color(0xFFEC4899),
      },
      {
        'icon': Icons.flutter_dash,
        'title': AppStrings.achievement3,
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.business,
        'title': AppStrings.achievement4,
        'color': const Color(0xFFF59E0B),
      },
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.03),
            AppColors.accent.withOpacity(0.03),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 100,
        vertical: widget.isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          FadeTransition(
            opacity: _animation,
            child: Text(
              AppStrings.achievementsTitle,
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 32 : 42,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildDivider(),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.isMobile ? 1 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: widget.isMobile ? 3.0 : 3.5,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return _buildAchievementCard(
                achievement['icon'] as IconData,
                achievement['title'] as String,
                achievement['color'] as Color,
                index,
              );
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

  Widget _buildAchievementCard(
    IconData icon,
    String title,
    Color color,
    int index,
  ) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.03 : 1.0)
          ..rotateZ(isHovered ? 0.01 : 0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(isHovered ? 0.3 : 0.15),
              blurRadius: isHovered ? 25 : 15,
              offset: Offset(0, isHovered ? 8 : 4),
            ),
          ],
          border: Border.all(
            color: isHovered ? color : Colors.grey[200]!,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.isMobile ? 20 : 30),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: widget.isMobile ? 30 : 40,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: widget.isMobile ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              Icon(
                Icons.check_circle,
                color: color,
                size: widget.isMobile ? 24 : 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
