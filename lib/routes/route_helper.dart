import 'package:foodie/pages/cart/cart_page.dart';
import 'package:foodie/pages/food/popular_food_detail.dart';
import 'package:foodie/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/auth/sign_in_page.dart';
import '../pages/auth/sign_up_page.dart';
import '../pages/food/recommendedFoodDetail.dart';
import '../pages/home/food_page_body.dart';
import '../pages/home/home_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String signInPage="/signIn-page";
  static const String foodPageBody = "/food-page-body";
  static const String mainFoodPage = "/main-food-page";
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getSignInPage()=>'$signInPage';
  static String getCartPage()=>'$cartPage';
  static String getFoodPageBody() => foodPageBody;
  static String getMainFoodPage() => mainFoodPage;


  static List<GetPage> routes=[
  GetPage(name: initial, page: ()=>HomePage()),
    GetPage(name: popularFood, page: () {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
       return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);

    },
        transition: Transition.fadeIn
    ),
    GetPage(name: initial, page: (){

      return MainFoodPage();
    }
    ),
    GetPage(name: recommendedFood, page: (){
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return RecommendedFoodDetail(pageId:int.parse(pageId!),page:page!);

      },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: (){

      return CartPage();
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: signInPage, page: (){

      return SignInPage();
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: mainFoodPage, page: () => MainFoodPage()),
    GetPage(name: foodPageBody, page: () => FoodPageBody(), transition: Transition.fadeIn),

  ];

}