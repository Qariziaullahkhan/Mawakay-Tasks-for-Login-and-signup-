import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  Future<void>login(String emai,String password)async{
    _isAuthenticated = true;
    notifyListeners();
  }
  Future<void>signip(String email, String password,String name, String confirmpassword)async{
    _isAuthenticated = true;
    notifyListeners();
  }
  void logout(){
    _isAuthenticated = false;
    notifyListeners();
  }
}