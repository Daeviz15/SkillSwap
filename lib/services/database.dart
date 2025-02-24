import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addUserDetails(Map<String, dynamic> userDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .set(userDetails);
  }

  Future addFirstTimeInfo(Map<String, dynamic> firstDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection('FirstTime')
        .doc(id)
        .set(firstDetails);
  }

  Future learnSkill(Map<String, dynamic> learnDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection('LearnSkill')
        .doc(id)
        .set(learnDetails);
  }

  Future shareSkill(Map<String, dynamic> shareDetails, String id) async {
    return await FirebaseFirestore.instance
        .collection('ShareSkill')
        .doc(id)
        .set(shareDetails);
  }

  Stream<QuerySnapshot> getUserDetails() {
    return FirebaseFirestore.instance.collection('Users').snapshots();
  }
}
