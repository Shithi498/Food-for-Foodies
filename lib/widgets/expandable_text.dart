import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/home/colors.dart';
import 'package:foodie/widgets/small_text.dart';

class Expandabletext extends StatefulWidget {
  final String text;
  const Expandabletext({super.key, required this.text});

  @override
  State<Expandabletext> createState() => _ExpandabletextState();
}

class _ExpandabletextState extends State<Expandabletext> {
  late String firstHalf;
  late String secondHalf;
  bool hiddentext=true;
  double textHeight = 100;

  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);

    }else{
      firstHalf=widget.text;
      secondHalf="";
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color:AppColors.paraColor,size:16,text: firstHalf):Column(
        children: [
          SmallText(height:1.8,color:AppColors.paraColor,size:16,text:hiddentext?(firstHalf+".."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddentext=!hiddentext;
              });

            },
            child:Row(
              children: [
                SmallText(text: "Show more",color:AppColors.mainColor),
                Icon(hiddentext?Icons.arrow_drop_down:Icons.arrow_drop_up,color:AppColors.mainColor),
              ],
            ) ,
          )
        ],
      ),



    );

  }
}
