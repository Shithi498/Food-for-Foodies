import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/contrtollers/popular_product_controller.dart';
import 'package:foodie/contrtollers/recommended_product_controller.dart';
import 'package:foodie/models/products_model.dart';
import 'package:foodie/pages/food/popular_food_detail.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/routes/route_helper.dart';
import 'package:foodie/utils/app_constants.dart';
import 'package:foodie/widgets/app_column.dart';
import 'package:foodie/widgets/big_text.dart';
import 'package:foodie/widgets/icon__and_text.dart';
import 'package:foodie/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class FoodPageBody extends  StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();


}

class _FoodPageBodyState extends State<FoodPageBody>{

  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Column(
    children: [
    GetBuilder<PopularProductController>(builder: (popularProducts) {
      return popularProducts.isloaded
          ? Container(
        // color:Colors.redAccent,
        height: 320,
        child: PageView.builder(
            controller: pageController,
            itemCount: popularProducts.popularProductList.length,
            itemBuilder: (context, position) {
              return _buildPageItem(
                  position, popularProducts.popularProductList[position]);
            }),
      )
          : CircularProgressIndicator(
        color: AppColors.mainColor,
      );
    }),
    GetBuilder<PopularProductController>(builder: (popularProducts) {
    return DotsIndicator(
    dotsCount: popularProducts.popularProductList.isEmpty
    ? 1
        : popularProducts.popularProductList.length,
    position: currPageValue,
    decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    );
    }),
    SizedBox(
    height: 30,
    ),
    Container(
    margin: EdgeInsets.only(left: 30),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    BigText(text: "Recommended"),
    SizedBox(
    width: 10,
    ),
    Container(
    child: BigText(
    text: ".",
    color: Colors.black,
    ),
    ),
    SizedBox(
    width: 10,
    ),
    Container(
    child: SmallText(text: "Food pairing"),
    ),
    ],
    ),
    ),

    // list of food and images
    GetBuilder<RecommendedProductController>(builder: (recommendedProducts) {
    return recommendedProducts.isloaded
    ? Container(
    height: MediaQuery.of(context).size.height,
    child: ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    itemCount: recommendedProducts.recommendedProductList.length,
    itemBuilder: (context, index) {
    return GestureDetector(
    onTap: () {
    Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
    },
    child: Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
    child: Row(
    children: [
    // image
    Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    image: DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage(
    AppConstants.BASE_URL +
    AppConstants.UPLOAD_URL +
    recommendedProducts
        .recommendedProductList[index].img!))),
    ),
    // text
    Expanded(
    child: Container(
    height: 100,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    bottomRight: Radius.circular(20)),
    color: Colors.white,
    ),
    child: Padding(
    padding: EdgeInsets.only(left: 10),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    BigText(
    text: recommendedProducts
        .recommendedProductList[index].name!),
    SizedBox(
    height: 10,
    ),
    SmallText(text: "With Chinese characteristics"),
    SizedBox(
    height: 10,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconAndText(
    icon: Icons.circle_sharp,
    text: "1.7km",
    iconColor: AppColors.mainColor,
    ),
    IconAndText(
    icon: Icons.access_time_rounded,
    text: "32min",
    iconColor: AppColors.iconColor2,
    ),
    IconAndText(
    icon: Icons.circle_sharp,
    text: "Normal",
    iconColor: AppColors.iconColor1,
    )
    ],
    )
    ],
    ),
    ),
    ))
    ],
    ),
    ),
    );
    },
    ),
    )
        : CircularProgressIndicator(color: AppColors.mainColor);
    }),
    ],
    ),
    );

  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale = scaleFactor + (currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: 200,
             // height: MediaQuery.of(context).size.height/5,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct.img!))),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 140,
                  margin: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: AppColumn(text: popularProduct.name!),
                  )))
        ],
      ),
    );
  }
}
