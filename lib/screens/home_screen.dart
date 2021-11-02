import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ride_share_app/utils/constants.dart';
import 'package:ride_share_app/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  final User? user;
  const HomeScreen({Key? key, required this.user }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain('Home'),

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

