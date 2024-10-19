import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodie/base/show_custome_message.dart';
import 'package:foodie/data/repository/user_repo.dart';
import 'package:foodie/models/singup_body_model.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/widgets/app_text_field.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/route_helper.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              child: Center(
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
            SizedBox(height: 20),
            AppTextField(
              textEditingController: nameController,
              hintText: "Name",
              icon: Icons.person,
            ),

            SizedBox(height: 8),
            AppTextField(
              textEditingController: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
            ),

            SizedBox(height: 8),
            AppTextField(
              textEditingController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: 8),
            AppTextField(
              textEditingController: passwordController,
              hintText: "Password",
              icon: Icons.password,
            ),
            SizedBox(height: 8),
            AppTextField(
              textEditingController: addressController,
              hintText: "Address",
              icon: Icons.location_on,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                await _registration();
              },
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(text: "Sign up", size: 30),
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () {
                  print("Sign In button tapped");
                  Get.toNamed(RouteHelper.getSignInPage());

                },
                text: "Have an account already?",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registration() async {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String address = addressController.text;

    User? user = await firebaseAuthServices.signUpWithEmailAndPassword(email, password);
    if (name.isEmpty) {
      showCustomSnackBar("Name cannot be empty", title: "Name");
    } else if (phone.isEmpty) {
      showCustomSnackBar("Phone Number cannot be empty", title: "Phone Number");
    } else if (address.isEmpty) {
      showCustomSnackBar("Address cannot be empty", title: "Phone Number");
    }
    else if (user != null) {
      showCustomSnackBar("Successful", title: "Successful");

      SignUpBody user = SignUpBody(
          id: FirebaseAuth.instance.currentUser!.uid,
          name: name,
        phone: phone,
        email: email,
        password: password,
        address: address
      );

      UserRepo userRepo = Get.find<UserRepo>();
      userRepo.createUser(user);
    } else {
      showCustomSnackBar("Unsuccessful", title: "Unsuccessful");
    }

  }
}
