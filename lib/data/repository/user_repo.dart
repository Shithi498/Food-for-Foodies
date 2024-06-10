//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:foodie/models/singup_body_model.dart';
//import 'package:get/get.dart';

//class UserRepo extends GetxController{
//static UserRepo get instance => Get.find();

 //final _db = FirebaseFirestore.instance;

 //createUser(SignUpBody user) async {
  //await _db.collection("Users").add(user.toJson());
// }
//}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/singup_body_model.dart';
import 'package:get/get.dart';

import '../api/api_cilent.dart';

class UserRepo extends GetxController {
 final ApiClient apiClient;

 UserRepo({required this.apiClient});

 static UserRepo get instance => Get.find();

 final FirebaseFirestore _db = FirebaseFirestore.instance;

 Future<void> createUser(SignUpBody user) async {
  try {
   await _db.collection("Users").add(user.toJson());
   print("User added successfully to Firestore.");
  } catch (e) {
   print("Error adding user to Firestore: $e");
  }
 }

 Future<SignUpBody> getUserDetails(String email) async {
  final snapshot = await _db.collection("Users").where(
      "Email", isEqualTo: email).get();
  final userData = snapshot.docs
      .map((e) => SignUpBody.fromSnapshot(e))
      .single;
  return userData;
 }

 Future<List<SignUpBody>> allUser() async {
  final snapshot = await _db.collection("Users").get();
  final userData = snapshot.docs.map((e) => SignUpBody.fromSnapshot(e))
      .toList();
  return userData;
 }


}


