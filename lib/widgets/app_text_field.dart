import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  AppTextField({super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height:60,
      width: 300,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon,
              color:AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 1,
              )
          ),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 1,
              )
          ),
        ),
      ),
    );
  }
}
