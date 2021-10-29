import 'package:flutter/material.dart';
import 'package:ride_share_app/widgets/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/Image1.png'),
                fit: BoxFit.fill,
                ),
                
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251,.5),
                          blurRadius: 20.0,
                          offset: Offset(0,10),
                        ),
                      ],
                      
                    ),
                    child: Column(
                      children:<Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border:Border(bottom:BorderSide(color: Colors.grey),),
                            color: Colors.white,
                          ),

                          child: TextField(
                            decoration: InputDecoration(
                              border :InputBorder.none,
                              hintText: "Mobile Number",
                              hintStyle: TextStyle(color:Colors.grey[400],)
                            ),
                          )
                        )
                      ]
                    ),
                    ),

                  SizedBox(
                    height: 30,
                  ),
                  Container(height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(143, 150, 251,1),
                        Color.fromRGBO(143, 150, 251,.9),
                    ])
                  ),
                  child: Center(
                    child: Text("Get OTP",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                    ),),
                  )
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
