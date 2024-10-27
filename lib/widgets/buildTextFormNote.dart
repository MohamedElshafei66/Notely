import 'package:flutter/material.dart';
import 'package:notes/shared/AppStyle.dart';
import '../shared/AppColor.dart';
// ignore: must_be_immutable
class BuildTextFormNote extends StatelessWidget {
   BuildTextFormNote({
    super.key,
    required this.hint,
    required this.maxLines,
    required this.maxLength,
    required this.controller,
    required this.validator,
    required this.style
  });
  String hint;
  int maxLines;
  int maxLength;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextStyle style;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator,
      controller:controller,
      cursorColor:AppColor.buttonColor,
      style:style,
      maxLines:maxLines,
      maxLength:maxLength,
      decoration:InputDecoration(
        hintText:hint,
        hintStyle:AppStyle.folderStyle,
        border:OutlineInputBorder(
            borderSide:BorderSide.none
        ),
      ),
    );
  }
}
