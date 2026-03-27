import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createUser(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credentials.user?.sendEmailVerification();
      return credentials.user;
    } on FirebaseAuthException catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  signIn(String email, String password) async {
    try{
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user?.emailVerified ?? false) {
        return credentials.user;
      } else {
        print('Email not verified. Please verify your email before signing in.');
        return null;
      }
    }
    catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
}
