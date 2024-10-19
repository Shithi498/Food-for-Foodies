import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/widgets/account_widget.dart';
import 'package:foodie/widgets/app_icon.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/app_text_field.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});


  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> getCurrentUserData() async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // return await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
      return firestore.collection('Users').doc(_auth.currentUser!.uid).snapshots();
    } else {
      throw Exception('No user logged in');
    }


  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.toNamed(RouteHelper.signInPage);
  }

  Future<void> _deleteAccount() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {

        await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).delete();



        await currentUser.delete();



        _logout();

        Get.snackbar("Success", "Account deleted successfully");
      } catch (e) {
        Get.snackbar("Error", "Failed to delete account: $e");
      }
    } else {
      Get.snackbar("Error", "No user is logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: AppIcon(icon: Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.yellowColor,
                iconColor: Colors.white,
                iconSize: 65,
                size: 120,
              ),

                StreamBuilder<DocumentSnapshot>(

                  stream:   () async* {
                    yield* await getCurrentUserData();
                 }(),


                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("An error occurred: ${snapshot.error}"));
                    return Center(child: Text("Error fetching data"));
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text("No user data found"));
                  }

                  var client = snapshot.data;
                  return Column(
                    children: [
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(color:Colors.black,text: client?['f_name']?.toString()  ?? "N/A"),
                      ),
                      SizedBox(height: 20),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(text: client?['phone']?.toString()  ?? "N/A"),
                      ),
                      SizedBox(height: 20),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(text: client?['email']?.toString()  ?? "N/A"),
                      ),
                      SizedBox(height: 20),

                      SizedBox(height: 20),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(text: client?['address']?.toString()  ?? "N/A"),
                      ),

                      SizedBox(height: 30),
                    ],
                  );
                },
              ),
              GestureDetector(
                onTap: _deleteAccount, // Call the delete account function
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                  child: BigText(text: "Delete Account", color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
