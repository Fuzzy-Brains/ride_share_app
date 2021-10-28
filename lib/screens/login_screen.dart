import 'package:flutter/material.dart';
import 'package:ride_share_app/widgets/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain('LOGIN'),
      body: Container(
      ),
    );
  }
}
