import '../models/blog_model.dart';

final List<BlogPost> blogPosts = [
  BlogPost(
    title:
        'Mastering Flutter: The Most Challenging Topics & How to Conquer Them',
    excerpt:
        'A deep dive into the hardest Flutter concepts including State Management, BLoC pattern, Advanced Animations, and Custom Rendering. Learn proven strategies to overcome these challenges.',
    date: 'Nov 17, 2024',
    category: 'Flutter',
    readTime: '12 min read',
    imageUrl: 'assets/images/bloc.png',
    url: '#flutter-challenges',
    tags: ['Flutter', 'BLoC', 'State Management'],
  ),
  BlogPost(
    title: 'Understanding Flutter\'s Rendering Pipeline: The Ultimate Guide',
    excerpt:
        'Deep dive into Flutter\'s rendering engine, RenderObjects, and CustomPainter. Learn how Flutter draws pixels on screen and master the most complex rendering concepts.',
    date: 'Nov 15, 2024',
    category: 'Flutter',
    readTime: '15 min read',
    imageUrl: 'assets/images/web.png',
    url: '#rendering-pipeline',
    tags: ['Flutter', 'Rendering', 'Performance'],
  ),
];
