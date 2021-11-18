import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/lender_screen.dart';


class FindMyVehicle extends StatefulWidget {
  final User? user;
  const FindMyVehicle({Key? key, required this.user }) : super(key: key);

  @override
  _FindMyVehicleState createState() => _FindMyVehicleState();
}

class _FindMyVehicleState extends State<FindMyVehicle> {
  Database db= Database();
  QuerySnapshot? snapshot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicle();
  }

  getVehicle() async{
    await db.findMyVehicle(widget.user, widget.user!.uid).then((value) {
      setState(() {
        snapshot = value;
      });
    });
    print(snapshot!.docs[0].get('reg_no'));
  }

  @override
  Widget build(BuildContext context) {
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
                builder: (c) => LenderScreen(user:widget.user)
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
      body: Column(
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
                      "https://images.carandbike.com/bike-images/medium/bajaj/pulsar-150/bajaj-pulsar-150.webp?v=52",
                    ))),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 24),
            child: Text('You can find your vehicles registered with us '
                'at following locations at their respective times.', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black
            ),),
          ),
          Container(
            child: snapshot!=null ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c,i){
                return vehicleTile(reg_no: snapshot!.docs[i].get('reg_no'), location: snapshot!.docs[i].get('location'));
              },
              itemCount: snapshot!.docs.length,
            ):Container(),
          )
        ],
      ),
    );
  }

  Widget vehicleTile({required String reg_no, required String location}){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [

          Container(
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reg_no, style: const TextStyle(
                    color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 6,),
                Text(location, style: const TextStyle(
                    color: Colors.black, fontSize: 16
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
