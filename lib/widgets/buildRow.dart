import 'package:flutter/material.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppStyle.dart';
// ignore: must_be_immutable
class BuildRow extends StatefulWidget {
  final String text1;
  final String text2;
  void Function()? onTap;
   BuildRow({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });
  @override
  State<BuildRow> createState() => _BuildRowState();
}
class _BuildRowState extends State<BuildRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children:[
         Text(
          widget.text1,
          style:AppStyle.buildRowStyle1
        ),
         const SizedBox(
            width:Appsized.size5
        ),
         GestureDetector(
          onTap:widget.onTap,
          child: Text(
            widget.text2,
            style:AppStyle.buildRowStyle2
          ),
        ),
      ],
    );
  }
}
