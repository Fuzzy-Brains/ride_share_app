import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_app/screens/login_screen.dart';
import 'package:ride_share_app/screens/otp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride Share App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const LoginScreen(),
    );
  }
}
