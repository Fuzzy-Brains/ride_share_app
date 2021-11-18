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

  Future saveVehicleData(User? user, String reg_no, String owner, String location, bool availability) async {
    CollectionReference vehicles = _database.collection('vehicles');
    return vehicles.doc(reg_no).set({
      'user_id': user!.uid,
      'reg_no': reg_no,
      'owner': owner,
      'location': location,
      'availability': availability
    });
  }

  Future findMyVehicle(User? user, String reg_no) async{
    CollectionReference vehicles = _database.collection('vehicles');
    return await vehicles.where('user_id', isEqualTo: user!.uid).get();
  }

  Future confirmRide(User? user, String src, String dest, String code, String reg_no) async{
    CollectionReference rides= _database.collection('rides');
    await rides.add({
      'src':src,
      'dest':dest,
      'user_id': user!.uid,
      'code':code,
      'booking_time': DateTime.now(),
      'return_time': null,
      'reg_no': reg_no
    });
  }

  Future findVehicle(String location) async{
    CollectionReference vehicles = _database.collection('vehicles');
    return await vehicles.where('location', isEqualTo: location).get();
  }


  // Future updateProfile(User? user, String name, String email, String aadhaar_no,
  //     String pan_no, String card_no, String address) async{
  //   CollectionReference users = _database.collection('users');
  //   return users.doc(user!.uid).set({
  //     'name': name,
  //     'email': email,
  //     'aad'
  //   });
  // }
}