import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  // Fetch matching users who share skills
  Future<Map<String, dynamic>> profileSkills() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      final userSkills = await FirebaseFirestore.instance
          .collection('ShareSkill')
          .doc(user.uid)
          .get();

      final userLearnSkills = await FirebaseFirestore.instance
          .collection('LearnSkill')
          .doc(user.uid)
          .get();

      final sharedSkills = userSkills.data()?['Share_Skill'] as List? ?? [];
      final learnSkills = userLearnSkills.data()?['Learn_Skill'] as List? ?? [];

      return {
        'sharedSkills': sharedSkills,
        'learnSkills': learnSkills,
      };
    } catch (e) {
      debugPrint('Error fetching user skills: $e');
      return {
        'sharedSkills': [],
        'learnSkills': [],
      };
    }
  }
}
