// ignore_for_file: use_build_context_synchronously

import 'package:buy_buddy/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseAuthHelper {
  static FireBaseAuthHelper instance = FireBaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get getAuthChange=> _auth.authStateChanges();

 Future<bool> login(String email, String password, BuildContext context)async{
 
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      return true;
    }on FirebaseAuthException catch(error){
      showMessage(error.code);
      return false;
    }
  }


   Future<bool> signUp(String email, String password, BuildContext context)async{
 
    try {
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      return true;
    }on FirebaseAuthException catch(error){
      showMessage(error.code);
      return false;
    }
  }
}
