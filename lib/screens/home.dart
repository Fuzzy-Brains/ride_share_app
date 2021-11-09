import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/user_screen.dart';
import 'package:ride_share_app/utils/constants.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({Key? key, required this.user }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database db= Database();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                db.setUserRole(widget.user, 'rider');
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (c)=> UserScreen(user: widget.user)
                ));
              },
              child: Container(
                width: size.width * 0.6,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Take A Ride', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                db.setUserRole(widget.user, 'lender');
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (c)=> UserScreen(user: widget.user)
                ));
              },
              child: Container(
                width: size.width * 0.6,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Lend A Ride', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
