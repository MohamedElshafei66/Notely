import 'package:flutter/material.dart';
import 'package:notes/shared/AppStyle.dart';
import '../shared/AppColor.dart';
import 'buildGetureDetector.dart';
// ignore: must_be_immutable
class BuildAppBar extends StatefulWidget implements PreferredSizeWidget {
   BuildAppBar({super.key,required this.onTap,required this.Icon,required this.text});
   void Function()? onTap;
   IconData Icon;
   String   text;
  @override
  State<BuildAppBar> createState() => _BuildAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
class _BuildAppBarState extends State<BuildAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle:true,
      backgroundColor:AppColor.scaffoldColor,
      leading:BuildGetureDetector(
        onTap:widget.onTap,
        icon:widget.Icon,
        color:AppColor.cursorColor,
        size:30,
      ),
      title:Text(
        widget.text,
        style:AppStyle.appBarStyle
      ),
    );
  }
}
