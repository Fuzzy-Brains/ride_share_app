import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_share_app/utils/constants.dart';

class LenderScreen extends StatefulWidget {
  final User? user;
  const LenderScreen({Key? key, required this.user }) : super(key: key);

  @override
  _LenderScreenState createState() => _LenderScreenState();
}

class _LenderScreenState extends State<LenderScreen> {

  late GoogleMapController _mapController;

  late Position currentPosition;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    currentPosition = position;

    LatLng latLng = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(45.521563, -122.677433),
      zoom: 16
  );

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
    locatePosition();
  }

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
                    'Add A Vehicle', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){

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
                    'Where\'s My Vehicle?', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){

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
                    'Request For Return', style: TextStyle(fontWeight: FontWeight.bold, color: white, fontSize: 24),
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
