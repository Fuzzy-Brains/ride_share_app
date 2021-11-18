import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/backend/database.dart';

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
      body: Column(
        children: [
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
