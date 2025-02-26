import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_swap/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class SoftProvider extends ChangeNotifier {
  // State management
  final Map<String, bool> _tappedStates = {};
  final Map<String, bool> _tappedStatesTwo = {};
  int _currentStep = 1;
  int _selectedTab = 0;
  final uid = const Uuid();
  File? imagePath;

  File? get image => imagePath;

  Future<void> imagePicked() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedImage != null) {
      imagePath = File(pickedImage.path);
      notifyListeners();
    } else {
      print('no image seklectedf');
    }
  }

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _description = TextEditingController();

  TextEditingController get firstname => _firstName;
  TextEditingController get lastname => _lastName;
  TextEditingController get description => _description;
  // Getters
  int get selectedTab => _selectedTab;
  int get currentStep => _currentStep;
  bool onTap(String key) => _tappedStates[key] ?? false;
  bool onTapTwo(String key) => _tappedStatesTwo[key] ?? false;

  String? validateFields() {
    if (_firstName.text.trim().isEmpty) {
      return 'Please enter your first name';
    } else if (_lastName.text.trim().isEmpty) {
      return 'Please enter your last name';
    } else if (_description.text.trim().isEmpty) {
      return 'Please briefly describe yourself ';
    } else if (imagePath == null) {
      return 'Please select a profile image ';
    }
    return null;
  }

  // State update methods
  void select(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  void setTapped(String key, bool value) {
    _tappedStates[key] = value;
    notifyListeners();
  }

  void setTappedTwo(String key, bool value) {
    _tappedStatesTwo[key] = value;
    notifyListeners();
  }

  void decrementStep() {
    if (_currentStep > 1) {
      _currentStep--;
      notifyListeners();
    }
  }

  void incrementStep() {
    if (_currentStep < 3) {
      _currentStep++;
      notifyListeners();
    }
  }

  Future<void> proceed(BuildContext context) async {
  String? fieldErrors = validateFields();
  final id = uid.v4();
  
  if (fieldErrors != null) {
    _showSnackBar(fieldErrors, context);
    return;
  }

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User not authenticated')),
    );
    return;
  }

  // Firebase Storage reference
  final  storageRef = FirebaseStorage.instance
      .ref()
      .child('profile_images')
      .child('${id}_${imagePath!.path.split('/').last}');

  String imageUrl = '';

  try {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      },
    );

    // Upload image to Firebase Storage
    await storageRef.putFile(imagePath!);

    // Get the download URL of uploaded image
    imageUrl = await storageRef.getDownloadURL();

    // Process skills
    final learnSkill = _tappedStates.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final shareSkill = _tappedStatesTwo.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Firebase Database operations
    await Future.wait([
      Database().learnSkill({'Learn_Skill': learnSkill}, user.uid),
      Database().shareSkill({
        'Share_Skill': shareSkill,
        'uid': user.uid,
        'First_Name': _firstName.text,
        'Last_Name': _lastName.text,
        'Description': _description.text,
        'User_Image': imageUrl, // Firebase image URL
      }, user.uid),
      Database().addFirstTimeInfo(
        {'isSetupComplete': true, 'User-Email': user.email},
        user.uid,
      ),
    ]);

    // Close loading dialog
    Navigator.of(context).pop();
    Get.offAllNamed('/navigate');
  } on FirebaseException catch (e) {
    debugPrint('Firebase error: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Firebase error: ${e.message}')),
    );
  } catch (e) {
    debugPrint('General error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An error occurred. Please try again.')),
    );
  }
}
  void _showSnackBar(String message, BuildContext context, {Color? color}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? Theme.of(context).colorScheme.error,
        content: Text(message,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
