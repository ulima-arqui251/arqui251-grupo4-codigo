import 'archivo.dart';

class Avist {
  final int? id;
  final String? description;
  final Archivo? archivo;
  final double longitud;
  final double latitud;
  final DateTime detectedAt;

  final String departamentoId;
  final int userId;

  Avist({
    this.id,
    required this.longitud,
    required this.latitud,
    required this.detectedAt,
    required this.archivo,
    required this.userId,
    required this.departamentoId,
    this.description,
  });

  factory Avist.fromJson(Map<String, dynamic> json) {
    return Avist(
      id: json['id'],
      longitud: double.parse(json['longitud'].toString()),
      latitud: double.parse(json['latitud'].toString()),
      description: json['description'],
      userId: json['userId'],
      departamentoId: json['departamentoId'],
      archivo:
          json['archivo'] == null ? null : Archivo.fromJson(json['archivo']),
      detectedAt: DateTime.parse(json['detectedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'longitud': longitud,
      'latitud': latitud,
      'description': description,
      'userId': userId,
      'departamentoId': departamentoId,
      'archivo': archivo?.toJson(),
      'detectedAt': detectedAt.toIso8601String(),
    };
  }
}
