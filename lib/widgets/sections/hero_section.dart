import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../constants/app_constants.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: widget.isMobile ? 0 : AppDimensions.navBarHeight,
      ),
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
      child: Stack(
        children: [
          // Animated background circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.15),
                    AppColors.accent.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondaryGradient[0].withOpacity(0.15),
                    AppColors.secondaryGradient[1].withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isMobile ? 20 : 100,
                  vertical: widget.isMobile ? 60 : 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.heroGreeting,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 24 : 32,
                        color: AppColors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.name,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 32 : 64,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          letterSpacing: 1.2,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    widget.isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'I\'m a',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      AppStrings.heroTitle1,
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      AppStrings.heroTitle2,
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      AppStrings.heroTitle3,
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'I\'m a ',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                  height: 60,
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        AppStrings.heroTitle1,
                                        textStyle: GoogleFonts.poppins(
                                          fontSize: 28,
                                          color: AppColors.accent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        speed: const Duration(
                                          milliseconds: 100,
                                        ),
                                      ),
                                      TypewriterAnimatedText(
                                        AppStrings.heroTitle2,
                                        textStyle: GoogleFonts.poppins(
                                          fontSize: 28,
                                          color: AppColors.accent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        speed: const Duration(
                                          milliseconds: 100,
                                        ),
                                      ),
                                      TypewriterAnimatedText(
                                        AppStrings.heroTitle3,
                                        textStyle: GoogleFonts.poppins(
                                          fontSize: 28,
                                          color: AppColors.accent,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        speed: const Duration(
                                          milliseconds: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 30),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: widget.isMobile ? double.infinity : 600,
                      ),
                      child: Text(
                        AppStrings.heroDescription,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 14 : 20,
                          color: AppColors.white70,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    MouseRegion(
                      onEnter: (_) => setState(() => _isHovering = true),
                      onExit: (_) => setState(() => _isHovering = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        transform: Matrix4.identity()
                          ..scale(_isHovering ? 1.05 : 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: _isHovering
                                  ? [AppColors.accentOrange, AppColors.accent]
                                  : [AppColors.accent, AppColors.accent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.5),
                                blurRadius: _isHovering ? 20 : 10,
                                offset: Offset(0, _isHovering ? 8 : 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: widget.onContactTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.isMobile ? 35 : 45,
                                vertical: widget.isMobile ? 18 : 22,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            icon: const Icon(Icons.rocket_launch, size: 22),
                            label: Text(
                              AppStrings.ctaButton,
                              style: GoogleFonts.poppins(
                                fontSize: widget.isMobile ? 16 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
