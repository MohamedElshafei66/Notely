import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/core/utils/image_Manger.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildButton.dart';
import 'package:notes/widgets/buildRow.dart';
import '../../../shared/appColor.dart';
import '../../widgets/buildTextForm.dart';
import 'login_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.only(left:Appsized.size1,right:Appsized.size1),
            child: Form(
              key:formState,
              child:Column(
                children: <Widget>[
                  SizedBox(
                    height:Appsized.size7
                  ),
                  Column(
                    children:[
                      Image.asset(
                        ImageManger.logoNative,
                        height:130,
                      ),
                      Text(
                          AppString.forgetPassword,
                          style:AppStyle.forgetPassStyle2
                      )
                    ],
                  ),
                  SizedBox(
                    height:Appsized.size2,
                  ),
                  BuildTextForm(
                    validator:(text){
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text!);
                      if(text == null || text.isEmpty){
                        return "this field shouldn't be empty";
                      }
                      else if(emailValid == false){
                        return "please enter correct email";
                      }
                      return null;
                    },
                    prefixIcon:Icons.email,
                    controller:email,
                    hint:AppString.email,
                    lines:1,
                  ),
                  SizedBox(
                    height:Appsized.size2,
                  ),
                  BuildButton(
                      onPressed:()async{
                        if(email.text == ""){
                          Fluttertoast.showToast(
                              msg: "Firstly,you must enter your email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.fillColor,
                              textColor:AppColor.cursorColor,
                              fontSize: 16.0
                          );
                          return;
                        }
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email:email.text
                          );
                          Fluttertoast.showToast(
                              msg: "check your email to change password",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.fillColor,
                              textColor:AppColor.cursorColor,
                              fontSize: 16.0
                          );
                        }catch(e){
                          Fluttertoast.showToast(
                              msg: "enter your correct email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.fillColor,
                              textColor:AppColor.cursorColor,
                              fontSize: 16.0
                          );
                        }
                      },
                      text:AppString.reset,
                      color:AppColor.buttonColor,
                      width:150.0,
                  ),
                  SizedBox(
                    height:Appsized.size1,
                  ),
                  BuildRow(
                      onTap:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                          return LoginScreen();
                        }));
                      },
                      text1:AppString.rememberPassword,
                      text2:AppString.loginNow
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}
