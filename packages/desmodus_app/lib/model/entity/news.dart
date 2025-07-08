class News {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime? publishedAt;
  final String? author;
  final String? content;

  News({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.publishedAt,
    this.author,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      publishedAt: json['publishedAt'] != null 
          ? DateTime.parse(json['publishedAt']) 
          : null,
      author: json['author'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt?.toIso8601String(),
      'author': author,
      'content': content,
    };
  }
}