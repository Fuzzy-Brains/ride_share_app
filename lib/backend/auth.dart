
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth{
  User? _user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((result) {
        _user = result.user;
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    return _user;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((result){
        _user = result.user;
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
    return _user;
  }

  Future signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}