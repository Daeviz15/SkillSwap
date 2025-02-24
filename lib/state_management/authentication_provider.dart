import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AuthenticationProvider extends ChangeNotifier {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final id = const Uuid();
  bool _showIcon = false;

  TextEditingController get email => _email;
  TextEditingController get password => _password;
  TextEditingController get confirmPassword => _confirmPassword;

  bool get showIcon => _showIcon;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validateEmail() {
    if (_email.text.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!EmailValidator.validate(_email.text.trim())) {
      return 'Invalid email address';
    }

    // Domain validation
    if (!_validateDomain(_email.text.trim())) {
      return 'Invalid email domain';
    }

    return null;
  }

  String? validatePassword() {
    if (_password.text.trim().isEmpty) {
      return 'Please enter your password';
    } else if (_password.text.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword() {
    if (_confirmPassword.text.trim().isEmpty) {
      return 'Please confirm your password';
    } else if (_confirmPassword.text.trim() != _password.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool _validateDomain(String email) {
    final List<String> invalidDomains = ['gmaipp.com', 'tempmail.com'];
    final String domain = email.split('@').last;
    return !invalidDomains.contains(domain);
  }

  Future<void> register(BuildContext context) async {
    // Validation
    String? emailError = validateEmail();
    String? passwordError = validatePassword();
    String? confirmPasswordError = validateConfirmPassword();

    if (emailError != null) {
      _showSnackBar(emailError, context);
      return;
    }
    if (passwordError != null) {
      _showSnackBar(passwordError, context);
      return;
    }
    if (confirmPasswordError != null) {
      _showSnackBar(confirmPasswordError, context);
      return;
    }

    // Proceed with registration if no errors
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

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // Send email verification
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _showSnackBar(
          'A verification email has been sent to ${user.email}. Please verify your email to complete registration.',
          context,
          color: const Color.fromARGB(255, 56, 140, 182),
        );
      }

      Navigator.of(context).pop();
      Get.toNamed('/category');
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Dismiss the dialog
      _showSnackBar(error.message ?? 'An error occurred', context);
    }
  }

  Future<void> login(BuildContext context) async {
    if (_email.text.trim().isEmpty) {
      _showSnackBar('Please enter your email', context);
      return;
    }
    if (!EmailValidator.validate(_email.text.trim())) {
      _showSnackBar('Invalid email address', context);
      return;
    }
    if (_password.text.trim().isEmpty) {
      _showSnackBar('Please enter your password', context);
      return;
    }
    if (_password.text.trim().length < 6) {
      _showSnackBar('Password must be at least 6 characters', context);
      return;
    }

    // Show loading indicator
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

    try {
      await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      Navigator.of(context).pop(); // Dismiss the dialog
      Get.toNamed('/navigate');
      _showSnackBar('Login Successful', context,
          color: const Color.fromARGB(255, 56, 140, 182));
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop(); // Dismiss the dialog
      _showSnackBar(error.message ?? 'An error occurred', context);
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

  void togglePasswordVisibility() {
    _showIcon = !_showIcon;
    notifyListeners();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
