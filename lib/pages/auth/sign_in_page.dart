import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/auth/sign_up_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custome_message.dart';
import '../../routes/route_helper.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import '../home/colors.dart';

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Adjust the radius
                  image: DecorationImage(
                    image: AssetImage("assets/images/taco-truck.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            AppTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: 20),
            AppTextField(
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icons.password),
            SizedBox(height: 40),
            GestureDetector(
              onTap: _login, // Call _login instead of direct navigation
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Sign in",
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => SignUpPage()),
                text: "Create account",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar("Please enter an email address", title: "Email");
      return;
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Please enter a valid email address", title: "Valid email");
      return;
    }

    if (password.isEmpty) {
      showCustomSnackBar("Please enter your password", title: "Password");
      return;
    } else if (password.length < 6) {
      showCustomSnackBar("Password must be at least 6 characters", title: "Password Length");
      return;
    }

    try {
      User? user = await firebaseAuthServices.signInWithEmailAndPassword(email, password);
      if (user != null) {
        // If login is successful, navigate to the home page
        showCustomSnackBar("Login Successful", title: "Success");
        Get.toNamed(RouteHelper.getInitial()); // Navigate to the initial page
      } else {
        showCustomSnackBar("Login Failed", title: "Error");
      }
    } catch (e) {
      showCustomSnackBar("Error: $e", title: "Login Failed");
    }
  }
}
