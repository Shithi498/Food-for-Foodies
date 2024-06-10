import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/contrtollers/cart_controller.dart';
import 'package:foodie/contrtollers/popular_product_controller.dart';
import 'package:foodie/pages/cart/cart_page.dart';
import 'package:foodie/pages/home/main_food_page.dart';
import 'package:foodie/routes/route_helper.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:foodie/widgets/app_column.dart';
import 'package:foodie/widgets/app_icon.dart';
import 'package:foodie/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custome_message.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon__and_text.dart';
import '../../widgets/small_text.dart';
import '../home/colors.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
   PopularFoodDetail({super.key,required this.pageId,required this.page});

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
  Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      body:Stack(
        children: [
//background image
          Positioned(
            left:0,
              right:0,
              child: Container(
width:double.maxFinite,
                height:350,
                decoration: BoxDecoration(
                  image:DecorationImage(
                    fit:BoxFit.cover,
                    image:NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
          )),
          //icon
          Positioned(
            top:45,
            left:20,
            right:20, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             GestureDetector(
               onTap:(){
               if(page=="cartpage"){
                 Get.toNamed(RouteHelper.cartPage);
               }else{
                 Get.toNamed(RouteHelper.getInitial());
               }
          },
               child:
               AppIcon(icon: Icons.arrow_back_ios),
             ),
             GestureDetector(
                onTap: (){
                 Get.toNamed(RouteHelper.getCartPage());
               },
                 child: AppIcon(icon: Icons.shopping_cart_outlined),
            )







],
),
          ),
          //introduction to food
          Positioned(
              left:0,
              right:0,
              bottom:0,
              top:70,
              child: Container(
               padding:EdgeInsets.only(left: 20,right:20,top:70) ,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  ),
                  color:Colors.white
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:product.name!),
                    SizedBox(height: 20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: 20,),
                    Expanded(
                        child:
                        SingleChildScrollView(
                            child:
                            Expandabletext(text:product.description!)))

                  ],
                )
          ))
        ],
      ),
          bottomNavigationBar:GetBuilder<PopularProductController>(builder: (popularProduct){
            return Column(
                mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                padding:EdgeInsets.only(top:30,bottom:30,left:30,right:30),
                decoration:BoxDecoration(
                    color:AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                    )
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top:20,bottom:20,left:20,right:20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Colors.white
                      ),
                      child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                popularProduct.setQuantity(false);
                              },
                              child: Icon(Icons.remove,color: AppColors.signColor,),
                            ),
                            SizedBox(width: 5,),
                            BigText(text: popularProduct.inCartItems.toString()),
                            SizedBox(width: 5,),
                            GestureDetector(
                              onTap: (){
                                popularProduct.setQuantity(true);
                              },
                              child:Icon(Icons.add,color: AppColors.signColor,),
                            )

                          ]
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        popularProduct.addItem(product);


                      },
                      child: Container(
                          padding: EdgeInsets.only(top:20,bottom: 20,right: 20,left:20),

                          child:BigText(text: "\$ ${product.price!} | Add to cart",color: Colors.white,),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.mainColor
                          )
                      ),
                    )

                  ],
                )
            )
              ],
            );




          },)

    );
  }
}
