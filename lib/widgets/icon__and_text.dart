import 'package:flutter/cupertino.dart';
import 'package:foodie/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  const IconAndText({super.key,
    required this.icon,
    required this.text,

    required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color:iconColor,),
        SizedBox(width: 3,),
        SmallText(text: text,),
      ],
    );
  }
}
