import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foodie/widgets/big_text.dart';
import 'package:foodie/widgets/small_text.dart';

import 'colors.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  //header
  body:Column(
    children: [
      Container(
        margin: EdgeInsets.only(top:45,bottom:15),
          padding: EdgeInsets.only(left: 20,right: 20),
          child:Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
BigText(text: "Bangladesh",color:AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(text:"Dhaka",color:Colors.black54) ,
                    //  Icon(Icons.arrow_drop_down_rounded)
            ],
                    )

                  ],
                ),
             /*   Center(
                  child:Container(
                    width:45,
                    height:45,
                    child: Icon(Icons.search,color:Colors.white),
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:AppColors.mainColor,
                    ) ,
                  )

                )*/
              ],
            ) ,
          )
      ),
      //body
      Expanded(child: SingleChildScrollView(
        child: FoodPageBody(),
      ))

    ],
  )
);
    //return const Placeholder();
  }
}
