import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> verifyPhoneNumber(String phoneNumber) async{
  //   try{
  //     await _auth.verifyPhoneNumber(
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: verificationCompleted,
  //         verificationFailed: verificationFailed,
  //         codeSent: codeSent,
  //         timeout: const Duration(seconds: 60),
  //         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  //   }catch(e){
  //     print(e);
  //   }
  // }

}