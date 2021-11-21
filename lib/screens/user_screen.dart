import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_share_app/backend/auth.dart';
import 'package:ride_share_app/config/config.dart';
import 'package:ride_share_app/models/places.dart';
import 'package:ride_share_app/screens/login.dart';
import 'package:ride_share_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:ride_share_app/screens/Profile.dart';
import 'package:ride_share_app/screens/Submit.dart';

String Source="Source";
String Destination="Destination";

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
  Auth auth = Auth();

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

  void signOut() async{
    await auth.signOut().then((value){
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
                        child: Text('${widget.user!.email}', style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                      )
                    ],
                  ),
                ),
                ListTile(item: 'Home', iconData: Icons.home, action: (){
                  Navigator.pop(context);
                }),
                ListTile(item: 'Profile', iconData: Icons.person, action: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (c)=> EditProfilePage(user:widget.user)
                  ));
                }),
                ListTile(item: 'Settings', iconData: Icons.settings, action: (){
                  
                }),
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
            zoomControlsEnabled: false,
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
            left: 0,
            right: 0,
            top: 120,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              height: 245,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width:300,
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
                    child: MyStatefulWidget(),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 50,
                    width: 300,
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
                    child: MyStatefulWidget1(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (c)=> SubmitPage(user:widget.user,source:Source,destination:Destination)
          ));
          print(Source);
          print(Destination);
          // Add your onPressed code here!
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
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


// for source
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Source,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          Source = newValue!;
        });
      },
      items: <String>['Source', 'Nehru Chowk', 'Guru Ghasidas Vishwavidyalay ', 'Railway Station Bilaspur']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

    );
  }
}


// for destination


class MyStatefulWidget1 extends StatefulWidget {
  const MyStatefulWidget1({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget1> createState() => _MyStatefulWidgetState1();
}

/// This is the private State class that goes with MyStatefulWidget.

class _MyStatefulWidgetState1 extends State<MyStatefulWidget1> {


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Destination,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          Destination = newValue!;
        });
      },
      items: <String>['Destination', 'Nehru Chowk', 'Guru Ghasidas Vishwavidyalay ', 'Railway Station Bilaspur']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(

          value: value,
          child: Text(value),

        );
      }).toList(),
    );
  }
}

// button


