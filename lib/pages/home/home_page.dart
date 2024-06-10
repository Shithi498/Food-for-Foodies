import 'package:flutter/material.dart';
import 'package:foodie/pages/account/account_page.dart';
import 'package:foodie/pages/auth/sign_up_page.dart';
import 'package:foodie/pages/cart/cart_history.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/pages/home/main_food_page.dart';

import '../cart/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _selectedIndex=0;
  List pages=[
    MainFoodPage(),
   // SignUpPage(),
    //CartHistory(),
    AccountPage(),
    CartPage(),
  ];
  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
       currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,),
               label:"Home" ),
       /*   BottomNavigationBarItem(
              icon: Icon(Icons.login,),
              label:"Signin/Login" ),*/
          BottomNavigationBarItem(
              icon: Icon(Icons.person,),
              label:"me" ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart,),
              label:"cart" )

    ],
      )
    );
  }
}
