import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_share_app/config/config.dart';
import 'package:ride_share_app/models/places.dart';
import 'package:ride_share_app/screens/login_screen.dart';
import 'dart:convert';
import 'package:ride_share_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  final User? user;
  const UserScreen({Key? key, required this.user }) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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

  void openDrawer(){
    _scaffoldKey.currentState!.openDrawer();
  }

  List<String> items = ["Home", "Profile", "Settings"];
  List<IconData> icons = [Icons.home, Icons.person, Icons.settings];
  List<Function> actions = [
    // Specify functions of each list item dynamically
    // () { Navigator.pop(context) },
    // () { Navigator.pop(context) },
    // () { Navigator.pop(context) },
  ];

  Widget itemList(){
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index){
        return ListTile(
          iconData: icons[index],
          item: items[index],
          action: ()=> Navigator.pop(context),
        );
      },
      itemCount: items.length,
    );
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
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/profile_picture.png' , width: 80, height: 80,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('${widget.user!.phoneNumber.toString()}', style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                    )
                  ],
                ),
              ),
              itemList()
            ],
          ),
        )
      ),

      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
          ),
          Positioned(
            child: GestureDetector(
              onTap: (){
                openDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.menu),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
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
                child: Icon(Icons.exit_to_app),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: white
                ),
              ),
            ),
            top: 50,
            right: 30,
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 90,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              height: 245,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54, blurRadius: 6, spreadRadius: 0.5, offset: Offset(0.7, 0.7)
                          )
                        ]
                    ),
                    child: TextField(
                      onChanged: (place){
                        findPlaces(place);
                      },
                      decoration: InputDecoration(
                          hintText: 'Source Location',
                          icon: Icon(Icons.location_on),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54, blurRadius: 6, spreadRadius: 0.5, offset: Offset(0.7, 0.7)
                          )
                        ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Destination Location',
                          icon: Icon(Icons.search),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void findPlaces(String placeName) async{
    if(placeName.length>0){
      String api = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
          "?input=$placeName&key=$MAPS_API_KEY"
          "&location=${currentPosition.latitude}%2C${currentPosition.longitude}"
          "&radius=50";

      var response = await http.get(Uri.parse(api));
      var body = json.decode(response.body);

      if(body["status"]=="OK"){
        var predictions = body["predictions"];
        var placesList = (predictions as List).map((e) => Place.fromJson(e)).toList();

      }
    }
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

