import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/user_screen.dart';
import 'package:ride_share_app/utils/constants.dart';




class SubmitPage extends StatefulWidget {
  final User? user;
  final String source;
  final String destination;
  const SubmitPage({Key? key, required this.user,required this.source,required this.destination }) : super(key: key);
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  bool showPassword = false;
  String? code;
  Database db= Database();
  QuerySnapshot? snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      code = randomBetween(100000, 999999).toString();
    });
  }

  confirm() async{
    await db.findVehicle(widget.source).then((value) {
      snapshot = value;
    });
    String reg_no = snapshot!.docs[0].get('reg_no');
    String owner = snapshot!.docs[0].get('owner');
    await db.confirmRide(widget.user, widget.source, widget.destination, code!, reg_no).then((value) {
      db.saveVehicleData(widget.user, reg_no, owner, widget.destination, false);
      Fluttertoast.showToast(msg: "Ride Booked Successfully");
    });
  }

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(

                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1604344929197-c89e3ef3c25b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80",
                        ))),
              ),
              SizedBox(height: 40,),
              Container(
                width: size.width * 0.6,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${randomBetween(100000, 999999)}' , style: TextStyle(
                      fontWeight: FontWeight.bold, color: white, fontSize: 24),
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
                child: Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: 150,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Center(
                      child: Text(
                        'You can get your bike at ${widget.source}. Collect your bike in 30 mins otherwise'
                            ' your booking will be cancelled.', style: TextStyle(
                          fontWeight: FontWeight.bold, color: black, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  confirm();
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
                      'Confirm Your Ride' , style: TextStyle(
                        fontWeight: FontWeight.bold, color: white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

