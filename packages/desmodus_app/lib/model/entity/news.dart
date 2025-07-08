class News {
  final int id;  // Cambiar de String a int
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime? publishedAt;
  final String? author;
  final String? content;
  final bool isImportant;

  News({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.publishedAt,
    this.author,
    this.content,
    this.isImportant = false,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? json['content']?.substring(0, 150) ?? '',
      imageUrl: json['image_url'],
      publishedAt: json['published_at'] != null 
          ? DateTime.parse(json['published_at']) 
          : null,
      author: json['author'],
      content: json['content'],
      isImportant: json['is_important'] ?? false,
    );
  }
}