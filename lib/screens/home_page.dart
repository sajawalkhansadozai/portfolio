import 'package:flutter/material.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/education_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/achievements_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/publications_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/navigation/desktop_navbar.dart';
import '../widgets/navigation/mobile_appbar.dart';
import '../widgets/navigation/mobile_drawer.dart';
import '../constants/app_constants.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  bool _showScrollToTop = false;

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 500) {
        if (!_showScrollToTop) {
          setState(() => _showScrollToTop = true);
        }
      } else {
        if (_showScrollToTop) {
          setState(() => _showScrollToTop = false);
        }
      }
    });
  }

  void _scrollToSection(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppDimensions.mobileBreakpoint;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: isMobile ? const MobileAppBar() : null,
      drawer: isMobile
          ? MobileDrawer(
              selectedIndex: _selectedIndex,
              onMenuTap: _scrollToSection,
            )
          : null,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    key: _sectionKeys[0],
                    child: HeroSection(
                      isMobile: isMobile,
                      onContactTap: () => _scrollToSection(6),
                    ),
                  ),
                  Container(
                    key: _sectionKeys[1],
                    child: AboutSection(isMobile: isMobile),
                  ),
                  Container(
                    key: _sectionKeys[2],
                    child: EducationSection(isMobile: isMobile),
                  ),
                  Container(
                    key: _sectionKeys[3],
                    child: SkillsSection(isMobile: isMobile),
                  ),
                  AchievementsSection(isMobile: isMobile),
                  Container(
                    key: _sectionKeys[4],
                    child: ProjectsSection(isMobile: isMobile),
                  ),
                  Container(
                    key: _sectionKeys[5],
                    child: PublicationsSection(isMobile: isMobile),
                  ),
                  Container(
                    key: _sectionKeys[6],
                    child: ContactSection(isMobile: isMobile),
                  ),
                ],
              ),
            ),
            if (!isMobile)
              DesktopNavBar(
                selectedIndex: _selectedIndex,
                onMenuTap: _scrollToSection,
              ),
            if (_showScrollToTop)
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                  backgroundColor: AppColors.accent,
                  child: const Icon(
                    Icons.arrow_upward,
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
