import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_constants.dart';
import '../models/blog_model.dart';

class RenderingBlogPage extends StatelessWidget {
  final bool isMobile;
  final BlogPost blogPost;

  const RenderingBlogPage({
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
            'Flutter\'s rendering pipeline is one of the most complex and fascinating aspects of the framework. Understanding how Flutter draws every pixel on the screen is crucial for building high-performance applications and debugging rendering issues. This comprehensive guide will take you through every stage of Flutter\'s rendering process.',
          ),
          _buildSection(
            'Why Is Rendering So Difficult?',
            'The rendering pipeline combines multiple complex concepts: widget composition, element trees, render objects, layer trees, and the actual painting process. Each stage has its own responsibilities and optimization strategies. Many developers struggle because they try to understand rendering without grasping the entire pipeline.',
          ),
          _buildHighlight(
            'Key Insight',
            'Flutter renders at 60 FPS (or 120 FPS on capable devices). Every frame must complete in 16ms (8ms for 120 FPS). Understanding the rendering pipeline helps you stay within this budget.',
          ),
          _buildSection(
            'The Three-Tree Architecture',
            'Flutter uses three parallel trees to manage UI rendering:',
          ),
          _buildBulletList([
            'Widget Tree: Immutable configuration, rebuilt frequently',
            'Element Tree: Mutable framework objects, long-lived',
            'RenderObject Tree: Actual layout and painting logic',
          ]),
          _buildSection(
            'Stage 1: Widget to Element',
            'When you call setState(), Flutter rebuilds widgets. The framework compares new widgets with existing elements to determine what changed. This reconciliation process is key to Flutter\'s performance.',
          ),
          _buildCodeExample('Widget Build Process', '''@override
Widget build(BuildContext context) {
  return Container(
    child: CustomPaint(
      painter: MyCustomPainter(),
      child: Text('Hello'),
    ),
  );
}

// Flutter creates Elements for each widget
// ContainerElement → CustomPaintElement → TextElement'''),
          _buildSection(
            'Stage 2: Layout Phase',
            'The layout phase is where RenderObjects determine their sizes and positions. This follows the constraint-box model:',
          ),
          _buildBulletList([
            'Constraints go down the tree (parent → child)',
            'Sizes go up the tree (child → parent)',
            'Parent sets position of children',
          ]),
          _buildHighlight(
            'Common Mistake',
            'Understanding constraints is crucial. "Constraints go down, sizes go up" is the mantra. Children cannot be bigger than their parents allow.',
          ),
          _buildSection(
            'The Constraint System',
            'Flutter uses BoxConstraints to define minimum and maximum width/height. This system is fundamentally different from iOS/Android\'s constraint-based layouts:',
          ),
          _buildCodeExample(
            'BoxConstraints Example',
            '''// Tight constraints (exact size)
BoxConstraints.tight(Size(100, 100))

// Loose constraints (max size)
BoxConstraints.loose(Size(200, 200))

// Custom constraints
BoxConstraints(
  minWidth: 0,
  maxWidth: 300,
  minHeight: 50,
  maxHeight: 500,
)''',
          ),
          _buildSection(
            'Stage 3: Paint Phase',
            'After layout, each RenderObject paints itself using a Canvas. This is where CustomPainter comes in - one of Flutter\'s most powerful but complex features.',
          ),
          _buildCodeExample(
            'CustomPainter Implementation',
            '''class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint when needed
  }
}''',
          ),
          _buildSection(
            'Stage 4: Compositing',
            'Flutter uses a Layer tree for efficient compositing. Layers allow Flutter to repaint only what changed without redrawing the entire screen.',
          ),
          _buildBulletList([
            'RepaintBoundary creates new layers',
            'Opacity, Transform, and ClipPath create layers',
            'Too many layers hurt performance',
            'Too few layers cause unnecessary repaints',
          ]),
          _buildSection(
            'RenderObject Lifecycle',
            'Understanding the RenderObject lifecycle is crucial for advanced Flutter development:',
          ),
          _buildNumberedList([
            'Constructor: Initial setup',
            'attach(): Connected to render tree',
            'performLayout(): Calculate sizes and positions',
            'paint(): Draw on canvas',
            'detach(): Removed from tree',
          ]),
          _buildSection(
            'Performance Optimization Strategies',
            'Now that you understand the pipeline, here are optimization techniques:',
          ),
          _buildBulletList([
            'Use const constructors to avoid rebuilding widgets',
            'Implement shouldRepaint() correctly in CustomPainter',
            'Add RepaintBoundary for expensive subtrees',
            'Avoid deep widget trees (use composition)',
            'Use ListView.builder for long lists',
            'Profile with Flutter DevTools Performance tab',
          ]),
          _buildCodeExample(
            'Optimization Example',
            '''// Bad: Rebuilds everything
class BadExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(100, (i) => 
        ExpensiveWidget(index: i)
      ),
    );
  }
}

// Good: Uses const and builder
class GoodExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, i) => 
        const ExpensiveWidget(),
    );
  }
}''',
          ),
          _buildSection(
            'Advanced Concept: Sliver Rendering',
            'Slivers are the most advanced rendering concept in Flutter. They enable efficient scrolling by only rendering visible portions.',
          ),
          _buildBulletList([
            'CustomScrollView uses slivers',
            'SliverList, SliverGrid for scrollable content',
            'SliverAppBar for collapsing headers',
            'Building custom slivers requires deep understanding',
          ]),
          _buildSection(
            'Debugging Rendering Issues',
            'Flutter provides powerful tools for debugging rendering:',
          ),
          _buildNumberedList([
            'debugPaintSizeEnabled = true: Shows layout boundaries',
            'debugPaintLayerBordersEnabled = true: Shows layer boundaries',
            'debugPrintRenderObjectTree(): Prints render tree',
            'Flutter DevTools: Visual rendering inspector',
            'Performance overlay: Shows frame rendering time',
          ]),
          _buildHighlight(
            'Pro Tip',
            'Use "flutter run --profile" for accurate performance testing. Debug mode is 10-20x slower than release mode.',
          ),
          _buildSection(
            'Common Rendering Pitfalls',
            'Avoid these common mistakes:',
          ),
          _buildBulletList([
            'Building expensive widgets in build() method',
            'Not using const constructors',
            'Creating too many RepaintBoundaries',
            'Ignoring shouldRepaint() in CustomPainter',
            'Deep widget nesting (more than 10 levels)',
            'Rebuilding entire lists instead of individual items',
          ]),
          _buildSection(
            'The Rendering Equation',
            'Flutter\'s rendering performance can be summarized as:\n\nPerformance = (Widget Efficiency) × (Layout Efficiency) × (Paint Efficiency) × (Compositing Efficiency)\n\nOptimize all stages, not just one.',
          ),
          _buildSection(
            'Learning Path for Rendering Mastery',
            'To truly master Flutter rendering:',
          ),
          _buildNumberedList([
            'Study the widget catalog thoroughly (1-2 weeks)',
            'Read Flutter\'s rendering source code (2-3 weeks)',
            'Build custom RenderObjects (2-3 weeks)',
            'Master CustomPainter and Canvas (2 weeks)',
            'Create custom Slivers (2-3 weeks)',
            'Profile and optimize real apps (ongoing)',
          ]),
          _buildSection(
            'Conclusion',
            'Flutter\'s rendering pipeline is complex but logical. The three-tree architecture (Widget → Element → RenderObject) enables both developer productivity and runtime performance. Understanding constraints, layout, painting, and compositing unlocks the full power of Flutter.\n\nThe rendering pipeline might seem daunting, but it\'s actually one of Flutter\'s greatest strengths. Once you understand how it works, you can build incredibly performant UIs and debug issues that would be impossible to solve otherwise.\n\nStart with simple CustomPainters, then progress to custom RenderObjects, and eventually tackle Slivers. Each step will deepen your understanding of how Flutter draws every pixel on screen.',
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
