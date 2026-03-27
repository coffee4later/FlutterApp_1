import 'package:cloud_firestore/cloud_firestore.dart';

class ProfesorDAO {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference profesorRef;

  ProfesorDAO()
    : profesorRef = FirebaseFirestore.instance.collection('profesor');

  Future<int> insertProfesor(Map<String, dynamic> data) async {
    try {
      await profesorRef.doc().set(data);
      return 1;
    } catch (e) {
      print("Error:" + e.toString());
      return 0;
    }
  }

  Future<int> updateProfesor(String id, Map<String, dynamic> data) async {
    try {
      await profesorRef.doc(id).update(data);
      return 1;
    } catch (e) {
      print("Error: " + e.toString());
      return 0;
    }
  }

  Future<bool> deleteProfesor(String id) async {
    try {
      await profesorRef.doc(id).delete();
      return true;
    } catch (e) {
      print("Error:" + e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProfesores() {
    return profesorRef
        .withConverter<Map<String, dynamic>>(
          fromFirestore: (snap, _) => snap.data() ?? {},
          toFirestore: (value, _) => value,
        )
        .snapshots();
  }
}
