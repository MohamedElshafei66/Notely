import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/shared/AppColor.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
// ignore: must_be_immutable
class GoogleButton extends StatefulWidget {
  void Function()? onTap;
   GoogleButton({super.key,required this.onTap});
  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}
class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
          border:Border.all(
              color:AppColor.cursorColor
          ),
          borderRadius:BorderRadius.circular(10)
      ),
      child: GestureDetector(
        onTap:widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(top:Appsized.size5,bottom:Appsized.size5),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              FaIcon(
                FontAwesomeIcons.google,
                color:Colors.grey,
              ),
              SizedBox(
                width:Appsized.size1,
              ),
              Text(
                AppString.google,
                style:AppStyle.googleStyle
              ),
            ],
          ),
        ),
      ),
    );
  }
}
