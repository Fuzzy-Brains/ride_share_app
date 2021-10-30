import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async{
    try{
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: onVerificationCompleted,
          verificationFailed: onVerificationFailed,
          codeSent: onCodeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout);
    }catch(e){
      Fluttertoast.showToast(msg: "$e");
    }
  }

  Future onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) async{
    Fluttertoast.showToast(msg: "$phoneAuthCredential");
  }

  Future onVerificationFailed(FirebaseAuthException firebaseAuthException) async{
    Fluttertoast.showToast(msg: "$firebaseAuthException");
  }

  Future onCodeSent(String vId, int? resendToken) async{
    Fluttertoast.showToast(msg: "Code sent : $vId");
  }

  Future onCodeAutoRetrievalTimeout(String vId) async{
    Fluttertoast.showToast(msg: "Time out : $vId");
  }
}