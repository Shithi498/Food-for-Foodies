import 'package:flutter/material.dart';

import 'package:foodie/pages/home/colors.dart';

import 'package:foodie/routes/route_helper.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:foodie/widgets/app_icon.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:foodie/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/show_custome_message.dart';

import '../../contrtollers/cart_controller.dart';
import '../../contrtollers/popular_product_controller.dart';
import 'package:foodie/contrtollers/recommended_product_controller.dart' ;



class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            top: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                BigText(text: "Cart")

              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                  var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                  } else if (recommendedIndex >= 0) {
                                    Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].name!, color: Colors.black54),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].price.toString(), color: Colors.redAccent),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => cartController.addItem(_cartList[index].product!, -1),
                                                  child: Icon(Icons.remove, color: AppColors.signColor),
                                                ),
                                                SizedBox(width: 5),
                                                BigText(text: _cartList[index].quantity.toString()),
                                                SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () => cartController.addItem(_cartList[index].product!, 1),
                                                  child: Icon(Icons.add, color: AppColors.signColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      BigText(text: "\$${cartController.totalAmount}", color: Colors.black),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
          GestureDetector(
          onTap: () {
          if (cartController.totalAmount > 0) {
          showCustomSnackBar("Confirmed", title: "Payment confirm");
          cartController.clear();

          } else {
          showCustomSnackBar("Not Confirmed", title: "Payment confirm");
          }
          },
          child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.mainColor,
          ),
          child: BigText(text: "Check out", color: Colors.white),
          ),
          ),

              ],
            ),
          );
        },
      ),
    );
  }
}