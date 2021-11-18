import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/lender_screen.dart';
import 'package:ride_share_app/screens/user_screen.dart';
import 'package:ride_share_app/utils/constants.dart';
import 'package:ride_share_app/screens/dropdown.dart';
import 'package:ride_share_app/screens/Profile.dart';

import 'package:ride_share_app/screens/login_screen.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({Key? key, required this.user }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Database db= Database();

  void openDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }

  void signOut() async{
    await _auth.signOut().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (c)=> LoginScreen()
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,

      body: Stack(
        children: [
          Positioned(
            top: 300,
            left: 50,
            right: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    db.setUserRole(widget.user, 'rider');
                    Navigator.push(context, MaterialPageRoute(
                        builder: (c)=> UserScreen(user: widget.user)
                    ));
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'User', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    db.setUserRole(widget.user, 'lender');
                    Navigator.push(context, MaterialPageRoute(
                        builder: (c)=> LenderScreen(user: widget.user)
                    ));
                  },
                  child: Container(
                    width: size.width * 0.6,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Lender', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: (){
                db.setUserRole(widget.user, 'rider');
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (c)=> UserScreen(user: widget.user),
                ));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.menu, color: white,),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor
                ),
              ),
            ),
            top: 50,
            left: 30,
          ),

          Positioned(
            child: GestureDetector(
              onTap: (){
                signOut();
              },
              child: Container(
                child: Icon(Icons.exit_to_app, color: white,),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor
                ),
              ),
            ),
            top: 50,
            right: 30,
          ),
        ],
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  final String item;
  final IconData iconData;
  final Function action;
  const ListTile({Key? key, required this.item, required this.iconData, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        action();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(iconData, color: Colors.grey, size: 28,),
            SizedBox(width: MediaQuery.of(context).size.width * 0.07,),
            Text(item, style: TextStyle(
                color: Colors.grey,
                fontSize: 18
            ),)
          ],
        ),
      ),
    );
  }
}
