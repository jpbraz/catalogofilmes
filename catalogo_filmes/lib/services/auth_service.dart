import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  _getUser() {
    _user = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String password, String photoURL) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _getUser();
        if (photoURL.isNotEmpty) {
          //await _user?.updateDisplayName(userName);
          await _user?.updatePhotoURL(photoURL);
          await _uploadUserPhoto(photoURL);
        }
        await FirebaseAuth.instance.setLanguageCode("pt-BR");
        await user?.sendEmailVerification();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado.');
      } else {
        throw AuthException('Verifique os valores inseridos.');
      }
    }
  }

  login(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => print(value.toString()));
      _getUser();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('E-mail inválido.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      } else {
        throw AuthException('Verifique os valores inseridos.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  _uploadUserPhoto(String photoUrl) async {
    final storageRef = FirebaseStorage.instance.ref('users-images');
    final imageRef = storageRef.child('${_user!.uid}.jpg');
    final imageFile = File(photoUrl);

    await imageRef.putFile(imageFile);
  }
}
