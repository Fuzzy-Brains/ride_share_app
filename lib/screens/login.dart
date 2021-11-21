import 'package:flutter/material.dart';
import 'package:ride_share_app/backend/auth.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/home.dart';
import 'package:ride_share_app/screens/signup.dart';
import 'package:ride_share_app/utils/constants.dart';
import 'package:ride_share_app/widgets/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  Auth auth = Auth();
  Database db= Database();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  login() async{
    if(formKey.currentState!.validate()){
      var email = emailTextEditingController.text.toString().trim();
      var password = passwordTextEditingController.text.toString().trim();
      setState(() {
        isLoading = true;
      });
      await auth.signInWithEmailAndPassword(email, password).then((user) {
        if(user!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (c)=> Home(user: user)
          ));
        }else{
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  signInWithGoogle() async{

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: appBarMain("Login"),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: size.height,
        child: isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LOGIN', style: headingTextStyle(),),
              SizedBox(height: size.height * 0.05,),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: emailTextEditingController,
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)
                              ? null : "Please provide a valid email address.";
                        },
                        decoration: textFieldsInputDecoration('Email', Icons.email),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: null,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: passwordTextEditingController,
                        validator: (val){
                          return val!.isEmpty || val.length<6 ? "Please enter 6+ characters." : null;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: textFieldsInputDecoration('Password', Icons.lock),
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: login,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('LOGIN', style: simpleButtonStyle()),
                ),
              ),

              SizedBox(height: size.height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? ', style: TextStyle(
                      color: primaryColor,
                      fontSize: 16
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignUpScreen()
                      ));
                    },
                    child: const Text('Sign Up', style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03,),

              GestureDetector(
                onTap: signInWithGoogle,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google.png', width: 24,height: 24,),
                      SizedBox(width: size.width * 0.04,),
                      Text("LOGIN WITH GOOGLE", style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
