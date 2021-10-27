import 'package:flutter/material.dart';

AppBar appBarMain(String title){
  return AppBar(
    title: Text(title, style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20
    ),),
    centerTitle: true,
  );
}