import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MenuItem extends StatelessWidget {
 MenuItem({required this.icon,required this.title,required this.subTitle,required this.color});

  final String icon,title,subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.0,color: color)

      ),
      child: Row(
        children: [
          SvgPicture.asset(icon,height: 24,width: 24,color:color ,),
          Container(
            padding: const EdgeInsets.only(left: 20),

            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                Text(subTitle,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
