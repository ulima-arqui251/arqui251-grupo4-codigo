class Archivo {
  final int id;
  final String imageUrl;

  const Archivo(this.id, this.imageUrl);

  // Factory constructor to create an instance from JSON
  factory Archivo.fromJson(Map<String, dynamic> json) {
    return Archivo(json['id'] as int, json['imageUrl'] as String);
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'imageUrl': imageUrl};
  }
}
