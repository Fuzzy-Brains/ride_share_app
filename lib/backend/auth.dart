
import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  User? _user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((result) {
      _user = result.user;
    });
    return _user;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((result){
      _user = result.user;
    });
    return _user;
  }
}