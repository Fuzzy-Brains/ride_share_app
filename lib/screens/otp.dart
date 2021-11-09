import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:ride_share_app/screens/user_screen.dart';

import 'home.dart';

class Otp extends StatefulWidget {
  final String phoneNumber;
  const Otp({Key? key, required this.phoneNumber }) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _pinOtpFocusNode = FocusNode();
  String? verificationId;

  signIn() async{
    String otp = _otpController.text;
    try{
      await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      )).then((value){
        if(value.user != null){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (c) => Home(user: value.user,),
          ));
        }
      });
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  initState(){
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async{
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
          _otpController.text = phoneAuthCredential.smsCode!;
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((value){
            if(value.user != null){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (c) => Home(user: value.user,),
              ));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) async{
          Fluttertoast.showToast(msg: e.toString());
        },
        codeSent: (String vId, [int? resendToken]) async{
          setState(() {
            verificationId = vId;
          });
        },
        codeAutoRetrievalTimeout: (String vId) async{
          setState(() {
            verificationId = vId;
          });
        },
        timeout: Duration(seconds: 60),
      );
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  final BoxDecoration _pinOTPFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.deepPurple),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/illustration-3.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    PinPut(
                      fieldsCount: 6,
                      textStyle: TextStyle(
                        fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold
                      ),
                      eachFieldWidth: 40,
                      eachFieldHeight: 55,
                      focusNode: _pinOtpFocusNode,
                      controller: _otpController,
                      selectedFieldDecoration: _pinOTPFieldDecoration,
                      submittedFieldDecoration: _pinOTPFieldDecoration,
                      followingFieldDecoration: _pinOTPFieldDecoration,
                      pinAnimationType: PinAnimationType.rotation,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signIn,
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: verifyPhoneNumber,
                child: const Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool first=true, last}) {
    return SizedBox(
      height: 40,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: false,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}