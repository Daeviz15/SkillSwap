import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Services {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Sign out the previous user to ensure account chooser is shown
      await GoogleSignIn().signOut();

      // Begin the interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the sign-in was successful (user selected an account)
      if (googleUser == null) {
        // User canceled the sign-in process
        print("Google Sign-In canceled by user");
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the access and ID tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Use the credential to sign in
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Get.offAllNamed('/navigate');

      // Log the signed-in user's details for debugging
      print("Signed in as: ${userCredential.user?.email}");

      return userCredential;
    } catch (e) {
      // Handle any errors during the sign-in process
      print("Error during Google Sign-In: $e");
      return null;
    }
  }
}
