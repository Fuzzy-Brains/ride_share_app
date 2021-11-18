import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/screens/user_screen.dart';
import 'package:ride_share_app/utils/constants.dart';




class SubmitPage extends StatefulWidget {
  final User? user;
  final String? source;
  final String? destination;
  const SubmitPage({Key? key, required this.user,required this.source,required this.destination }) : super(key: key);
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.indigo,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (c) => UserScreen(user: widget.user)
            ));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.indigo,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {

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
                    'Add A Vehicle', style: TextStyle(
                      fontWeight: FontWeight.bold, color: white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            // GestureDetector(
            //   onTap: (){
            //
            //   },
            //   child: Container(
            //     width: size.width * 0.6,
            //     height: 60,
            //     decoration: BoxDecoration(
            //       color: primaryColor,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Where\'s My Vehicle?', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: size.width * 0.9,
                height: 80,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Take in 30 min at ${widget.source}', style: TextStyle(
                      fontWeight: FontWeight.bold, color: white, fontSize: 24),
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

