import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSkillProvider extends ChangeNotifier {
  String? _firstName;
  String? _profileImage;

  String? get firstName => _firstName;
  String? get profileImage => _profileImage;

  /// Loads user profile details from SharedPreferences or Firebase.
  Future<void> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();

    // Attempt to load from cache
    _firstName = prefs.getString('first_name');
    _profileImage = prefs.getString('profile_image');

    if (_firstName != null && _profileImage != null) {
      notifyListeners();
    } else {
      await fetchAndCacheUserProfile();
    }
  }

  Future<void> fetchAndCacheUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User is not logged in");

      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('ShareSkill')
          .doc(userId)
          .get();

      final fetchedName = userDoc.data()?['First_Name'] ?? 'User';
      final fetchedImage = userDoc.data()?['User_Image'] ?? '';

      // Cache the data locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('first_name', fetchedName);
      await prefs.setString('profile_image', fetchedImage);

      // Update local variables
      _firstName = fetchedName;
      _profileImage = fetchedImage;

      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('first_name');
    await prefs.remove('profile_image');
    _firstName = null;
    _profileImage = null;
    notifyListeners();
  }

  /// Fetches users with matching skills.
  Future<List<Map<String, dynamic>>> matchSkills({bool showAll = false}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User is not logged in");

      final userId = user.uid;

      // Fetch the current user's "Learn Skills"
      final userLearnSkillDoc = await FirebaseFirestore.instance
          .collection('LearnSkill')
          .doc(userId)
          .get();

      final List userLearnSkills =
          userLearnSkillDoc.data()?['Learn_Skill'] ?? [];

      // Fetch matching users who share skills
      final shareSkillSnapshot = await FirebaseFirestore.instance
          .collection('ShareSkill')
          .where('uid', isNotEqualTo: userId)
          .where('Share_Skill', arrayContainsAny: userLearnSkills)
          .get();

      return shareSkillSnapshot.docs.map((doc) {
        final data = doc.data();
        final List shareSkills = data['Share_Skill'] as List;

        // Filter matching skills based on the toggle
        final List filteredSkills = showAll
            ? shareSkills
            : shareSkills
                .where((skill) => userLearnSkills.contains(skill))
                .toList();

        return {
          'uid': data['uid'],
          'matchingSkills': filteredSkills,
          'allSkills':
              shareSkills, // Optionally include all skills for "See All"
          'FirstName': data['First_Name'],
          'LastName': data['Last_Name'],
          'Description': data['Description'],
          'Profile_Image': data['User_Image'],
        };
      }).toList();
    } catch (e) {
      print('Error fetching matching skills: $e');
      return [];
    }
  }
}
