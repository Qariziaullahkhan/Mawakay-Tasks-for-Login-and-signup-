import 'package:flutter/material.dart';

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