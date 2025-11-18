import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_constants.dart';
import '../models/blog_model.dart';

class BlogPostPage extends StatelessWidget {
  final bool isMobile;
  final BlogPost blogPost;

  const BlogPostPage({
    super.key,
    required this.isMobile,
    required this.blogPost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [_buildHeader(), _buildContent()]),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: isMobile ? 500 : 600,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(blogPost.imageUrl),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Handle image loading error
          },
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.7),
              AppColors.secondary.withOpacity(0.85),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 100,
          vertical: isMobile ? 40 : 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.white, width: 1),
              ),
              child: Text(
                blogPost.category,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              blogPost.title,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 28 : 42,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.calendar,
                  size: 14,
                  color: AppColors.white70,
                ),
                const SizedBox(width: 8),
                Text(
                  blogPost.date,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.white70,
                  ),
                ),
                const SizedBox(width: 20),
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 14,
                  color: AppColors.white70,
                ),
                const SizedBox(width: 8),
                Text(
                  blogPost.readTime,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: blogPost.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.white.withOpacity(0.5)),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 40 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Introduction',
            'Based on developer feedback and industry experience, Flutter development comes with its own set of challenges that can make or break your learning journey. Whether you\'re a beginner or an experienced developer transitioning from native development, understanding these challenging concepts is crucial for mastering Flutter.',
          ),
          _buildSection(
            'The #1 Challenge: State Management',
            'State management consistently ranks as the most challenging topic in Flutter development. As your app grows, you need to track data across multiple screens, handle asynchronous operations, and ensure your UI updates correctly when state changes. The real challenge isn\'t just understanding one approach, but choosing the right one for your project from multiple options like Provider, BLoC, Riverpod, GetX, and Redux.',
          ),
          _buildHighlight(
            'Key Takeaway',
            'State management complexity increases exponentially with app size. What works for a simple app might not scale for enterprise applications.',
          ),
          _buildSection(
            'The BLoC Pattern: A Steep Learning Curve',
            'BLoC (Business Logic Component) stands out as particularly challenging because it requires understanding reactive programming with Streams and Sinks. Developers frequently mention:',
          ),
          _buildBulletList([
            'Steep learning curve requiring reactive programming knowledge',
            'Significant amount of boilerplate code',
            'Mental shift from imperative to reactive programming',
            'Complex data flow patterns that feel counterintuitive at first',
          ]),
          _buildSection(
            'Why BLoC Is Worth Learning',
            'Despite its complexity, BLoC provides excellent separation of concerns, makes testing easier, and scales well for large applications. The pattern enforces a unidirectional data flow that prevents many common bugs in complex applications.',
          ),
          _buildSection(
            'Advanced Animations: The Creative Challenge',
            'Advanced animations rank as another extremely difficult area. Flutter offers multiple animation types that each require different approaches:',
          ),
          _buildBulletList([
            'Implicit Animations: Easy to learn but limited in complexity',
            'Explicit Animations: Full control but requires deep understanding',
            'Custom Painters: Pixel-perfect control with steep learning curve',
            'Hero Animations: Cross-screen transitions with timing challenges',
            'Staggered Animations: Coordinating multiple animations simultaneously',
          ]),
          _buildCodeExample(
            'Example: Complex Animation Controller',
            '''AnimationController _controller = AnimationController(
  duration: const Duration(seconds: 2),
  vsync: this,
);

Animation<double> _animation = CurvedAnimation(
  parent: _controller,
  curve: Curves.easeInOut,
);

// Multiple synchronized animations
Animation<double> _scaleAnimation = Tween<double>(
  begin: 0.5,
  end: 1.0,
).animate(_animation);''',
          ),
          _buildSection(
            'Custom Rendering and Sliver Widgets',
            'Understanding Flutter\'s rendering pipeline requires deep technical knowledge. Developers struggle with:',
          ),
          _buildBulletList([
            'Complex scrolling behaviors using CustomScrollView',
            'Understanding constraints and how they flow through the widget tree',
            'Performance optimization in custom render objects',
            'Debugging layout issues in deeply nested widget trees',
            'Creating custom sliver widgets for advanced scrolling effects',
          ]),
          _buildSection(
            'Platform Channels and Native Integration',
            'When Flutter plugins don\'t provide what you need, platform channels become necessary but challenging:',
          ),
          _buildBulletList([
            'Writing platform-specific code in Swift/Kotlin',
            'Managing communication between Dart and native code',
            'Handling asynchronous platform calls',
            'Debugging across multiple language boundaries',
            'Maintaining code for multiple platforms simultaneously',
          ]),
          _buildSection(
            'The Mental Shift: The Hidden Challenge',
            'Many developers report that the hardest part isn\'t a specific topic but the mindset shift required:',
          ),
          _buildBulletList([
            'Moving from constraint-based layouts to Row/Column approach',
            'Understanding the widget tree and composition over inheritance',
            'Embracing declarative programming instead of imperative',
            'Rebuilding widgets efficiently without performance issues',
            'Thinking in terms of state changes rather than direct UI manipulation',
          ]),
          _buildHighlight(
            'Developer Insight',
            'The transition from native development or other frameworks can take weeks or months to fully grasp. Be patient with yourself during this learning process.',
          ),
          _buildSection(
            'Strategies to Conquer These Challenges',
            '1. **Start Simple**: Begin with Provider or Riverpod before diving into BLoC\n\n2. **Build Projects**: Theory only goes so far - build real applications\n\n3. **Read Official Documentation**: Flutter\'s docs are excellent and constantly updated\n\n4. **Join Communities**: Flutter communities are incredibly helpful\n\n5. **Study Source Code**: Read Flutter framework code to understand patterns\n\n6. **Master Dart First**: Strong Dart knowledge makes Flutter easier\n\n7. **Use DevTools**: Flutter DevTools helps visualize widget trees and performance\n\n8. **Practice Incremental Learning**: Don\'t try to learn everything at once',
          ),
          _buildSection(
            'Recommended Learning Path',
            'For beginners, I recommend this progression:',
          ),
          _buildNumberedList([
            'Master basic widgets and layouts (2-3 weeks)',
            'Learn simple state management with Provider (1-2 weeks)',
            'Build a complete CRUD app (2-4 weeks)',
            'Study navigation and routing (1 week)',
            'Explore advanced state management (BLoC/Riverpod) (3-4 weeks)',
            'Dive into animations (2-3 weeks)',
            'Learn custom painting and rendering (2-3 weeks)',
            'Master platform integration (2-3 weeks)',
          ]),
          _buildSection(
            'Conclusion',
            'Flutter\'s challenging topics are challenging for good reasons - they solve complex real-world problems. State management, BLoC pattern, advanced animations, and custom rendering might seem daunting, but they\'re the tools that enable you to build world-class applications.\n\nThe key is to approach these topics systematically, build projects that require these concepts, and don\'t hesitate to revisit basics when you\'re stuck. Remember, every expert Flutter developer once struggled with these same concepts.\n\nFor those writing Flutter books or courses, dedicate extra attention to state management patterns with practical, real-world examples. This is where beginners struggle most, but also where they gain the most value once they break through.',
          ),
          const SizedBox(height: 40),
          _buildDivider(),
          const SizedBox(height: 40),
          _buildAuthorSection(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 15 : 17,
              color: AppColors.grey,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlight(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.1),
            AppColors.accentOrange.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.accent.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: AppColors.accent, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 15 : 17,
                      color: AppColors.grey,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNumberedList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2, right: 12),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 15 : 17,
                      color: AppColors.grey,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.black87,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                code,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: isMobile ? 12 : 14,
                  color: AppColors.white,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary,
            AppColors.accent,
            AppColors.accent.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About the Author',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: AppColors.black87,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Sajawal Khan Sadozai is a software developer specializing in Flutter and mobile app development. With expertise in building scalable applications and a passion for sharing knowledge, Sajawal helps developers navigate the complexities of modern app development.',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.grey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
