import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  FirebaseFirestore _database = FirebaseFirestore.instance;

  Future setUserRole(User? user, String role) async{
    CollectionReference users = _database.collection('users');
    return users.doc(user!.uid).set({
      'user_id': user.uid,
      'phone_number': user.phoneNumber,
      'role': role
    });
  }

  Future saveVehicleData(User? user, String reg_no, String owner){
    CollectionReference vehicles = _database.collection('vehicles');
    return vehicles.doc(reg_no).set({
      'user_id' : user!.uid,
      'reg_no' : reg_no,
      'owner' : owner
    });
  }
}