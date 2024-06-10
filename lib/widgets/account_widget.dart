import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/widgets/app_icon.dart';
import 'package:foodie/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon  appIcon;
  BigText bigText;
  AccountWidget({super.key,required this.appIcon,required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),

child: Row(
  children: [
    appIcon,
    SizedBox(width:20),

  ],
),
    );
  }
}
