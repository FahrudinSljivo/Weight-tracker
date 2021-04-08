import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _dbInstance = FirebaseFirestore.instance;

  Future<void> addNewWeight(String uid, String weight, String time) async {
    await _dbInstance
        .collection('users')
        .doc(uid)
        .collection("weights")
        .doc(time)
        .set({
      'timestamp': time,
      'weight': weight,
    });
  }

  Future<void> editWeight(
      String weightId, String userId, String newWeight) async {
    await _dbInstance
        .collection('users')
        .doc(userId)
        .collection('weights')
        .doc(weightId)
        .update({
      "weight": newWeight,
    });
  }

  Future<void> deleteWeight(String weightId, String userId) async {
    await _dbInstance
        .collection('users')
        .doc(userId)
        .collection('weights')
        .doc(weightId)
        .delete();
  }
}
