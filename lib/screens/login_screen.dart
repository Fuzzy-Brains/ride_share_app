import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_share_app/backend/auth.dart';
import 'package:ride_share_app/widgets/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Auth auth = Auth();
  sendOtp() async{
    if(formKey.currentState!.validate()){
      var phoneNumberText = _controller.text.trim();
      String phone = "+91" + phoneNumberText;
      await auth.verifyPhoneNumber(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/Image1.png'),
                fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251,.5),
                          blurRadius: 20.0,
                          offset: Offset(0,10),
                        ),
                      ],

                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children:<Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              // border: Border(bottom:BorderSide(color: Colors.grey),),
                              color: Colors.white,
                            ),

                            child: TextFormField(
                              controller: _controller,
                              validator: (val){
                                return val!.isEmpty || val.length<10 ? 'Please enter a valid phone number.' : null;
                              },
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                border :InputBorder.none,
                                hintText: "Mobile Number (10 digits)",
                                icon: const Icon(Icons.phone),
                                hintStyle: TextStyle(color:Colors.grey[400],)
                              ),
                            )
                          )
                        ]
                      ),
                    ),
                    ),

                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: sendOtp,
                    child: Container(height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 150, 251,1),
                          Color.fromRGBO(143, 150, 251,.9),
                      ])
                    ),
                    child: const Center(
                      child: Text("Get OTP",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                      ),),
                    ),
                  )
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
