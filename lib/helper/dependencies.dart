
import 'package:foodie/contrtollers/account_controller.dart';
import 'package:foodie/contrtollers/cart_controller.dart';
import 'package:foodie/contrtollers/popular_product_controller.dart';
import 'package:foodie/data/api/api_cilent.dart';


import 'package:foodie/data/repository/popular_product_repo.dart';
import 'package:foodie/data/repository/user_repo.dart';
import 'package:foodie/pages/food/popular_food_detail.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:foodie/contrtollers/cart_controller.dart';
import 'package:foodie/contrtollers/popular_product_controller.dart';
import 'package:foodie/data/api/api_cilent.dart';
import 'package:foodie/data/repository/popular_product_repo.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../contrtollers/recommended_product_controller.dart';

import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));
 // Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(),apiClient: Get.find()));

  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  Get.lazyPut(() => AccountController(userRepo:Get.find()));

 // Get.lazyPut(() => AuthController(authRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

  //Get.lazyPut(() =>  CartController(cartRepo:Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));




}