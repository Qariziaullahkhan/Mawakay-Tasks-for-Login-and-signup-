import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Add signup logic using Firebase Auth and Firestore
  Future<void> signup(String name, String email, String password) async {
    // Implement sign up logic with error handling
    isLoading = true; // Update loading state before network call
    // ... Firebase Auth and Firestore code
    isLoading = false; // Update loading state after network call
  }
}
class LoginProvider with ChangeNotifier {
  // Login state properties
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters for login state properties
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Setters for login state properties with change notifications
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Notify UI about changes
  }

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  // Login function with error handling and loading indicator
  Future<void> login(String email, String password) async {
    isLoading = true; // Show loading indicator
   isLoading = false;
}
}