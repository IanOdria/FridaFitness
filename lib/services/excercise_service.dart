import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridafit/models/excercise.dart';

class ExerciseService {
  final _col = FirebaseFirestore.instance
      .collection('exercises')
      .withConverter<Exercise>(
        fromFirestore: (doc, _) => Exercise.fromDoc(doc),
        toFirestore: (exercise, _) => exercise.toMap(),
      );

  Stream<List<Exercise>> watchAll() => _col
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((s) => s.docs.map((d) => d.data().copyWith(id: d.id)).toList());

  Future<void> add(Exercise exercise) => _col.add(exercise).then((_) => null);
  Future<void> update(Exercise exercise) =>
      _col.doc(exercise.id).set(exercise, SetOptions(merge: true));
  Future<void> delete(String id) => _col.doc(id).delete();
}
