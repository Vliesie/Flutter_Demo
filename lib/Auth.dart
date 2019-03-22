import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth{
  Future<String> signInWithEmailandPassword(String email, String password);
  Future<String> CreateUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth { //Generic Authentication
  Future<String> signInWithEmailandPassword(String email, String password) async{
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> CreateUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> currentUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.uid;
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();

  }
}