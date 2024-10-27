import 'package:flutter/material.dart';
import 'package:notes/shared/AppColor.dart';
import 'package:notes/shared/AppStyle.dart';
// ignore: must_be_immutable
class BuildTextForm extends StatefulWidget {
  String?  Function(String?)? validator;
  String hint;
  IconData prefixIcon;
  TextEditingController controller;
  IconData? suffixIcon;
  final bool isPassword;
  int lines;
  int? maxLength;
   BuildTextForm({
    super.key,
    required  this.validator,
    required this.prefixIcon,
    required this.controller,
    required this.hint,
    this.suffixIcon,
    this.isPassword = false,
    this.maxLength,
    required this.lines,
  });
  @override
  State<BuildTextForm> createState() => _BuildTextFormState();
}
class _BuildTextFormState extends State<BuildTextForm> {
  bool _obscureText = true;
  void hideMyPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      maxLength:widget.maxLength,
      controller:widget.controller,
      maxLines:widget.lines,
      style:AppStyle.textFormStyle,
      cursorColor:AppColor.cursorColor,
      validator:widget.validator,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration:InputDecoration(
        filled:true,
        fillColor:AppColor.fillColor,
        hintText:widget.hint,
        hintStyle:AppStyle.hintStyle,
        prefixIcon:Icon(
          widget.prefixIcon,
          color:AppColor.cursorColor,
        ),
        suffixIcon: widget.isPassword ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color:AppColor.cursorColor,
          ),
          onPressed:hideMyPass,
        ) : null,
        focusedBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide.none
        ),
        enabledBorder:OutlineInputBorder(
            borderRadius:BorderRadius.circular(10),
            borderSide:BorderSide.none
        ),
      ),
    );
  }
}
