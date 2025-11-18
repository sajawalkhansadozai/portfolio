class BlogPost {
  final String title;
  final String excerpt;
  final String date;
  final String category;
  final String readTime;
  final String imageUrl;
  final String url;
  final List<String> tags;

  BlogPost({
    required this.title,
    required this.excerpt,
    required this.date,
    required this.category,
    required this.readTime,
    required this.imageUrl,
    required this.url,
    required this.tags,
  });
}
