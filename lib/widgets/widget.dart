import 'package:flutter/material.dart';
import 'package:ride_share_app/utils/constants.dart';

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