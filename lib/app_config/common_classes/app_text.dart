
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
 String  text;
 Color ?color = Colors.white;
 FontWeight? weight = FontWeight.w500 ;
 double? fontSize=12;
 TextAlign? textAlign=TextAlign.start;




  AppText(this.text, {super.key,this.color,this.weight,this.fontSize,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontWeight: weight,fontSize: fontSize,),textAlign: textAlign,);
  }
}
