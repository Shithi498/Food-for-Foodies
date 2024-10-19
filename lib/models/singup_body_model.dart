import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpBody{
  final String? id;
  String name;
  String phone,email,password,address;


  SignUpBody( {
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.address,
});

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();

    data["f_name"]=this.name;
    data["phone"]=this.phone;
    data["email"]=this.email;
    data["password"]=this.password;
    data["address"]=this.address;
    return data;
  }

  factory SignUpBody.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    final data = document.data();
    return SignUpBody(
        id: document.id,
        name:data!["f_name"],
        phone:data!["phone"],
        email:data!["email"],
        password:data!["password"],
        address:data!["address"]);
  }
}
