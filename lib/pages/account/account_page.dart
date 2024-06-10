import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/widgets/account_widget.dart';
import 'package:foodie/widgets/app_icon.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<DocumentSnapshot> getCurrentUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
    } else {
      throw Exception('No user logged in');
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
   // Get.offAllNamed('/login');
    Get.toNamed(RouteHelper.signInPage);
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
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.yellowColor,
              iconColor: Colors.white,
              iconSize: 75,
              size: 150,
            ),
            FutureBuilder<DocumentSnapshot>(
              future: getCurrentUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error fetching data"));
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text("No user data found"));
                }

                var client = snapshot.data!;
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
                      bigText: BigText(text: client['f_name'] ?? "N/A"),
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
                      bigText: BigText(text: client['phone'] ?? "N/A"),
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
                      bigText: BigText(text: client['email'] ?? "N/A"),
                    ),
                    SizedBox(height: 20),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: 25,
                        size: 50,
                      ),
                      bigText: BigText(text: client['address'] ?? "N/A"),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
