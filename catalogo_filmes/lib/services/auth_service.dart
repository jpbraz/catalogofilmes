import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  User? get user => _user;

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      isLoading = false;
      notifyListeners();
    });
  }
}
