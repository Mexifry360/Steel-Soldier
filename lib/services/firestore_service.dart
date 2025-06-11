import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logWorkoutFeedback({
    required String workoutName,
    required int painRating,
    required int effortRating,
    required DateTime date,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final docRef = _db.collection('users').doc(uid).collection('workouts').doc(date.toIso8601String());

    await docRef.set({
      workoutName: {
        'pain': painRating,
        'effort': effortRating,
      }
    }, SetOptions(merge: true));
  }
}
