import 'package:flutter/material.dart';
import 'package:ride_share_app/utils/constants.dart';
import 'package:flutter/material.dart';


AppBar appBarMain(String title){
  return AppBar(
    backgroundColor: white,
    leading: Icon(Icons.menu, color: primaryColor,),
    title: Text(title, style: const TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20
    ),),
    centerTitle: true,
  );
}

TextStyle headingTextStyle(){
  return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: primaryColor
  );
}

TextStyle simpleButtonStyle(){
  return const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

InputDecoration textFieldsInputDecoration(String hint, IconData icon){
  return InputDecoration(
      hintText: hint,
      icon: Icon(icon, color: primaryColor,),
      hintStyle: const TextStyle(
          color: Colors.grey,
      ),
      // border: InputBorder.none
  );
}