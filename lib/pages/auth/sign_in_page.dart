
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/auth/sign_up_page.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/widgets/app_text_field.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custome_message.dart';

import '../../routes/route_helper.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';



class SignInPage extends StatefulWidget {

  const SignInPage({super.key});

  _SignInPageState createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height:40 ,),
              Container(
                  child:Center(
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // You can adjust the radius as per your need
                          image: DecorationImage(
                            image: AssetImage("assets/images/taco-truck.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                  )

              ),
              ),
              SizedBox(height: 30,),
              AppTextField(textEditingController: emailController, hintText: "email", icon: Icons.email),
              SizedBox(height: 20,),
              AppTextField(textEditingController: passwordController, hintText: "password", icon: Icons.password),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () {
                  //if (page == "initial") {
                    Get.toNamed(RouteHelper.getInitial());
                 // }
                },
                child:Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.mainColor
                  ),
                  child:Center(
                    child: BigText(text: "Sign in",size: 30,),
                  ),
                ),
              ),


              SizedBox(height: 20,),
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                  text:"Create account",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                  )

              ))


            ],
          ),
        )

    );
  }

  Future<void> _login() async {

    //  var authController = Get.find<AuthController>();


    String email= emailController.text;
    String password= passwordController.text;
    User? user =await firebaseAuthServices.signInWithEmailAndPassword(email, password);
    if(user!=null){


      // else if(email.isEmpty){
      //    showCustomSnackBar("Email",title: "Email");
      //   }else if(!GetUtils.isEmail(email)){
      //   showCustomSnackBar("Enter valid email address",title: "Valid email");
      //   }else if(password.isEmpty){
      //    showCustomSnackBar("Password",title: "Password");
      //  }else if(password.length<6){
      // showCustomSnackBar("Password can not be less then 6",title: "Password length");
      //   }else{
      showCustomSnackBar("Succesful",title: "Succesful");

      //  SignUpBody signUpBody =SignUpBody(name: name,
      // phone: phone,
      //  email: email,
      //   password: password);
      // authController.registration(signUpBody).then((status){
      //  if(status.isSuccess){
      //   print("Success registration");
      //  }else{
      //    showCustomSnackBar(status.message);
      //   }
      //  });

    }else{
      showCustomSnackBar("UnSuccesful",title: "UnSuccesful");
    }

  }
}
