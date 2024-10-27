import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/screens/AuthPages/login_screen.dart';
import 'package:notes/shared/AppColor.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildButton.dart';
import 'package:notes/widgets/buildRow.dart';
import 'package:notes/widgets/buildTextForm.dart';
import '../../core/utils/image_Manger.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      body:Form(
        key:formState,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:Appsized.size1,right:Appsized.size1),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                SizedBox(
                  height:Appsized.size2,
                ),
                Center(
                  child: Image.asset(
                    "${ImageManger.logoNative}",
                    height:150,
                  ),
                ),
                Text(
                  AppString.createAcc,
                  style:AppStyle.welcomeStyle
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                Text(
                  AppString.userName,
                  style:AppStyle.labelStyle
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                BuildTextForm(
                  validator:(text){
                    if(text == null || text.isEmpty){
                      return "this field shouldn't be empty";
                    }
                    return null;
                  },
                  prefixIcon:Icons.person,
                  controller:username,
                  hint:AppString.userName,
                  lines:1,
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                Text(
                  AppString.email,
                  style:AppStyle.labelStyle
                ),
                SizedBox(
                  height:Appsized.size1,
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
                  height:Appsized.size1,
                ),
                Text(
                  AppString.password,
                  style:AppStyle.labelStyle
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                BuildTextForm(
                  validator:(text){
                    if(text == null || text.isEmpty){
                      return "this field shouldn't be empty";
                    }
                    return null;
                  },
                  prefixIcon:Icons.lock,
                  isPassword:true,
                  controller:password,
                  hint:AppString.password,
                  lines:1,
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor:AppColor.buttonColor, // Color for the checked box
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text:AppString.textSpan1,
                          style:AppStyle.textSpanStyle,
                          children:[
                            TextSpan(
                              text:AppString.textSpan2,
                              style:AppStyle.textSpanStyle2
                              // Add navigation functionality here if needed
                            ),
                            TextSpan(
                              text:AppString.textSpan3,
                              style:AppStyle.textSpanStyle2
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:Appsized.size2,
                ),
                BuildButton(
                  onPressed:()async{
                  if(formState.currentState!.validate()){
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email:email.text,
                        password:password.text,
                      );
                      FirebaseAuth.instance.currentUser!.sendEmailVerification();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return const LoginScreen();
                      }));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        Fluttertoast.showToast(
                            msg: "The password is too weak",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:AppColor.fillColor,
                            textColor:AppColor.cursorColor,
                            fontSize: 16.0
                        );
                      } else if (e.code == 'email-already-in-use') {
                        Fluttertoast.showToast(
                            msg: "The account already exists for that email.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:AppColor.fillColor,
                            textColor:AppColor.cursorColor,
                            fontSize: 16.0
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },

                  text:AppString.signUp,
                  width:400.0,
                  color:AppColor.buttonColor,
                ),
                SizedBox(
                  height:Appsized.size2,
                ),
                BuildRow(
                    onTap:(){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                        return LoginScreen();
                      }));
                    },
                    text1:AppString.haveAcc,
                    text2:AppString.login,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
