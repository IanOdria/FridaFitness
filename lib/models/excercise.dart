import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final String name;
  final String? description;
  final int? sets;
  final int? reps;
  final String? equipment;
  final String? gifUrl;
  final String? thumbUrl; // 👈 new field for preview thumbnails
  final DateTime createdAt;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    this.sets,
    this.reps,
    this.equipment,
    this.gifUrl,
    this.thumbUrl,
    required this.createdAt,
  });

  factory Exercise.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return Exercise(
      id: doc.id,
      name: d['name'] as String,
      description: d['description'] as String?,
      sets: (d['sets'] as num?)?.toInt(),
      reps: (d['reps'] as num?)?.toInt(),
      equipment: d['equipment'] as String?,
      gifUrl: d['gifUrl'] as String?,
      thumbUrl: d['thumbUrl'] as String?, // ✅ read from Firestore
      createdAt: (d['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'sets': sets,
        'reps': reps,
        'equipment': equipment,
        'gifUrl': gifUrl,
        'thumbUrl': thumbUrl, // ✅ write to Firestore
        'createdAt': Timestamp.fromDate(createdAt),
      };

  Exercise copyWith({
    String? id,
    String? name,
    String? description,
    int? sets,
    int? reps,
    String? equipment,
    String? gifUrl,
    String? thumbUrl,
    DateTime? createdAt,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      equipment: equipment ?? this.equipment,
      gifUrl: gifUrl ?? this.gifUrl,
      thumbUrl: thumbUrl ?? this.thumbUrl, // ✅ copy too
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
