import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/account/account_page.dart';
import 'package:foodie/pages/auth/sign_up_page.dart';
import 'package:foodie/pages/cart/cart_page.dart';
import 'package:foodie/pages/home/home_page.dart';
import 'package:foodie/pages/home/main_food_page.dart';
import 'package:foodie/routes/route_helper.dart';
import 'package:foodie/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'contrtollers/cart_controller.dart';
import 'contrtollers/popular_product_controller.dart';
import 'contrtollers/recommended_product_controller.dart';
import 'data/api/api_cilent.dart';
import 'data/repository/user_repo.dart';
import 'helper/dependencies.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Required for GetX initialization

  await Firebase.initializeApp(options:
  FirebaseOptions(
      apiKey: "AIzaSyDoOvLSyCp4ff0uDw4qN_joJkeb-lATSsc",
      appId: "1:381153531345:web:3cd7667f2595dcf24abcf0",
      messagingSenderId: "381153531345",
      projectId: "food-delivery-ba0f5"));


  Get.put(ApiClient(appBaseUrl:AppConstants.BASE_URL));  // Register a new instance of ApiClient

  Get.put(UserRepo(apiClient: Get.find()));
  Get.put(FirebaseAuthServices());

  await init();
    runApp(const MyApp());
  }



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      title: 'Flutter Demo',
       //home: HomePage(),
        initialRoute: RouteHelper.getSignInPage(),

     getPages: RouteHelper.routes,
        debugShowCheckedModeBanner: false
    );
  }
}
