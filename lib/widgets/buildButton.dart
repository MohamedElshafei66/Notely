import 'package:flutter/material.dart';
import '../shared/AppColor.dart';
import '../shared/AppSized.dart';
import '../shared/AppStyle.dart';
class BuildButton extends StatelessWidget {
  final width;
  final text;
  final void Function()? onPressed;
  final Color? color;
  const BuildButton({
    super.key,
    this.width,
    required this.onPressed,
    required this.text,
     this.color
  });
  @override
  Widget build(BuildContext context) {
    return  Container(
      width:width,
      child: MaterialButton(
        onPressed:onPressed,
        child:Padding(
          padding: const EdgeInsets.only(top:Appsized.size5,bottom:Appsized.size5,),
          child: Text(
              text,
              style:AppStyle.text3
          ),
        ),
        color:color,
        splashColor:AppColor.buttonColor,
        highlightColor:AppColor.buttonColor,
        shape:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide.none
        ),
      ),
    );
  }
}
