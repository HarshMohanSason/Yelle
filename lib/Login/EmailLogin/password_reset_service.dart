import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PasswordResetService extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSent = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isSent => _isSent;
  String? get errorMessage => _errorMessage;

  Future<void> sendOTPToEmailAddress(String emailAddress) async {
    _isLoading = true;
    _isSent = false;
    _errorMessage = null;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      _isSent = true;
      notifyListeners();
    } on SocketException catch (e) {
      _errorMessage = e.message;

    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            _errorMessage = 'Invalid email address.';
            break;
          case 'user-not-found':
            _errorMessage = 'No user found with this email.';
            break;
          case 'user-disabled':
            _errorMessage = 'User account is disabled.';
            break;
          case 'too-many-requests':
            _errorMessage = 'Too many requests. Try again later.';
            break;
          case 'operation-not-allowed':
            _errorMessage = 'Email/password accounts are not enabled.';
            break;
          default:
            _errorMessage = 'An unknown error occurred: ${e.code}';
            break;
        }
      } else {
        _errorMessage = 'An error occurred: ${e.toString()}';
      }

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}