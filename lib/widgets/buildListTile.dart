import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/shared/AppStyle.dart';
import '../shared/AppColor.dart';
// ignore: must_be_immutable
class BuildListTile extends StatefulWidget {
   BuildListTile({super.key, required this.text,required this.icon,required this.onTap});
  final String text;
  final IconData icon;
  void Function()? onTap;
  @override
  State<BuildListTile> createState() => _BuildListTileState();
}
class _BuildListTileState extends State<BuildListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: Container(
        height:50,
        decoration:BoxDecoration(
            color:AppColor.fillColor,
            borderRadius:BorderRadius.circular(10),
            border:Border.all(style:BorderStyle.none)
        ),
        child: ListTile(
          title:Text(
            widget.text,
            style:AppStyle.listTileStyle
          ),
          trailing:FaIcon(
            widget.icon,
            color:AppColor.forgetPassword,
          ),

        ),
      ),
    );
  }
}
