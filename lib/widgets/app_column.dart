import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/widgets/small_text.dart';

import '../pages/home/colors.dart';
import 'big_text.dart';
import 'icon__and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text),
        SizedBox(height: 10,),

        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor)),
            ),
            SizedBox(width: 5),
            SmallText(text: "4.5"),
            SizedBox(width: 5),
            SmallText(text: "1237"),
            SizedBox(width: 5),
            SmallText(text: "comments"),
          ],
        ),
        ),




        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconAndText(
                icon: Icons.circle_sharp,
                text: "1.7km",
                iconColor: AppColors.mainColor,
              ),
            ),
            Expanded(
              child: IconAndText(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2,
              ),
            ),
            Expanded(
              child: IconAndText(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
