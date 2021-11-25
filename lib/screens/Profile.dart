import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_share_app/backend/database.dart';
import 'package:ride_share_app/screens/user_screen.dart';
import 'package:ride_share_app/utils/constants.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  const EditProfilePage({Key? key, required this.user }) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController aadhaarController= TextEditingController();
  TextEditingController panController= TextEditingController();
  TextEditingController creditController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  bool showPassword = false;
  File? _file;
  String? _fileName= "Upload File";
  Database db= Database();
  QuerySnapshot? snapshot;

  saveProfile() async{
    String name= nameController.text.toString().trim();
    String email= emailController.text.toString().trim();
    String aadhaar= aadhaarController.text.toString().trim();
    String pan= panController.text.toString().trim();
    String credit= creditController.text.toString().trim();
    String address= addressController.text.toString().trim();
    await db.updateProfile(widget.user, name, email, aadhaar, pan, credit, address).then((value) {
      Fluttertoast.showToast(msg: "Profile Updated Successfully");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }
  getProfileData() async{
    await db.getProfileData(widget.user).then((value) {
      setState(() {
        snapshot = value;
      });
    });
    // print(snapshot!.docs[0].get('name'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.indigo,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.indigo,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: snapshot != null ? Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              Column(
                children: [
                  // Container(
                  //   width: 130,
                  //   height: 130,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //           width: 4,
                  //           color: Theme.of(context).scaffoldBackgroundColor),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             spreadRadius: 2,
                  //             blurRadius: 10,
                  //             color: Colors.black.withOpacity(0.1),
                  //             offset: Offset(0, 10))
                  //       ],
                  //       shape: BoxShape.circle,
                  //       image: DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: NetworkImage(
                  //             "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                  //           ))),
                  // ),
                  // Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     child: Container(
                  //       height: 40,
                  //       width: 40,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           width: 4,
                  //           color: Theme.of(context).scaffoldBackgroundColor,
                  //         ),
                  //         color: Colors.green,
                  //       ),
                  //       child: Icon(
                  //         Icons.edit,
                  //         color: Colors.white,
                  //       ),
                  //     )),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('name')}":"", false, nameController, TextInputType.text),
              buildTextField("E-mail", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('email')}":"", false, emailController,TextInputType.emailAddress),
              buildTextField("Aadhaar Number", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('aadhaar_no')}":"", false, aadhaarController, TextInputType.number),
              GestureDetector(
                onTap: () async{
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  _file = File(pickedFile!.path);
                  _fileName = "${widget.user!.uid}/aadhaar";
                  await db.uploadImageToFirebase(context, _file,_fileName, widget.user).then((value){
                    Fluttertoast.showToast(msg: "File Uploaded Successfully.");
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text('$_fileName', style: TextStyle(color: white, fontWeight: FontWeight.bold,
                              fontSize: 14),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              buildTextField("Pan Number", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('pan_no')}":"", false, panController, TextInputType.number),
              GestureDetector(
                onTap: () async{
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  _file = File(pickedFile!.path);
                  _fileName = "${widget.user!.uid}/pan";
                  await db.uploadImageToFirebase(context, _file,_fileName, widget.user).then((value){
                    Fluttertoast.showToast(msg: "File Uploaded Successfully.");
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text('$_fileName', style: TextStyle(color: white, fontWeight: FontWeight.bold,
                        fontSize: 14),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              buildTextField("Credit Card", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('credit_card_no')}":"", false, creditController, TextInputType.number),
              GestureDetector(
                onTap: () async{
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  _file = File(pickedFile!.path);
                  _fileName = "${widget.user!.uid}/credit";
                  await db.uploadImageToFirebase(context, _file,_fileName, widget.user).then((value){
                    Fluttertoast.showToast(msg: "File Uploaded Successfully.");
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text('$_fileName', style: TextStyle(color: white, fontWeight: FontWeight.bold,
                        fontSize: 14),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              buildTextField("Address", snapshot!.docs.length>0 ? "${snapshot!.docs[0].get('address')}":"", false, addressController, TextInputType.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      saveProfile();
                    },
                    color: Colors.indigo,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 45,)
                ],
              )
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            // border:
        ),
      ),
    );
  }
}