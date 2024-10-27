import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/provider/user_provider..dart';
import 'package:notes/screens/AuthPages/forgetpassword_screen.dart';
import 'package:notes/screens/FolderPages/home_screen.dart';
import 'package:notes/screens/AuthPages/signup_screen.dart';
import 'package:notes/shared/AppColor.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildButton.dart';
import 'package:notes/widgets/buildTextForm.dart';
import 'package:notes/widgets/googleButton.dart';
import 'package:provider/provider.dart';
import '../../core/utils/image_Manger.dart';
import '../../widgets/buildRow.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  void _loadUserData(BuildContext context, String email) {
    Provider.of<UserDataProvider>(context, listen: false)
        .loadDataUser(email);
  }
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final String userName = googleUser.displayName ?? '';
      final String email = googleUser.email;
      setState(() {
        loading = true;
      });
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _loadUserData(context, email);
      Provider.of<UserDataProvider>(context,listen:false).setDataUser(userName,email);
      Fluttertoast.showToast(
        msg: "Success Login",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.fillColor,
        textColor: AppColor.cursorColor,
        fontSize: 16.0,
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.fillColor,
          textColor: AppColor.cursorColor,
          fontSize: 16.0);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
  bool loading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      body:Form(
        key:formState,
        child:loading == true?
        const Center(
          child:CircularProgressIndicator(color:AppColor.forgetPassword,),
        ):
        SingleChildScrollView(
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
                 AppString.welcomeText,
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
                  children:[
                    Spacer(),
                    GestureDetector(
                      onTap:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                          return ForgetPassword();
                        }));
                      },
                      child: Text(
                        AppString.forgetPassword,
                        style:AppStyle.forgetPassStyle
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:Appsized.size1,
                ),
                BuildButton(
                    onPressed:()async{
                      if(formState.currentState!.validate()){
                        loading = true;
                        setState((){});
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email:email.text,
                            password:password.text
                        ).then((value){
                          if(FirebaseAuth.instance.currentUser!.emailVerified){
                            _loadUserData(context, email.text);
                            Provider.of<UserDataProvider>(context,listen:false)
                                .setDataUser(username.text,email.text);
                            Fluttertoast.showToast(
                                msg: "Success Login",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:AppColor.fillColor,
                                textColor:AppColor.cursorColor,
                                fontSize: 16.0
                            );
                            Future.delayed(
                                const Duration(seconds:2),
                                    (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                                    return const HomeScreen();
                                  }));
                                }
                            );
                          }
                          else{
                            loading = false;
                            setState((){});
                            Fluttertoast.showToast(
                                msg: "check your email to verify it.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:AppColor.fillColor,
                                textColor:AppColor.cursorColor,
                                fontSize: 16.0
                            );
                          }
                        }).catchError((e){
                          loading = false;
                          setState((){});
                          Fluttertoast.showToast(
                              msg: "Your email or password is wrong!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:AppColor.fillColor,
                              textColor:AppColor.cursorColor,
                              fontSize: 16.0
                          );
                        });
                      }
                    },
                    text:AppString.login,
                    width:400.0,
                    color:AppColor.buttonColor,
                ),
                SizedBox(
                  height:Appsized.size2,
                ),
                Row(
                  children:[
                    Expanded(
                      child: Divider(
                        color:AppColor.forgetPassword,
                        thickness:1,
                      ),
                    ),
                    SizedBox(
                      width:Appsized.size6,
                    ),
                    Text(
                        AppString.continueText,
                        style:AppStyle.continueStyle
                    ),
                    SizedBox(
                      width:Appsized.size6,
                    ),
                    Expanded(
                      child: Divider(
                        color:AppColor.forgetPassword,
                        thickness:1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:Appsized.size2,
                ),
                GoogleButton(
                    onTap:()async{
                      await signInWithGoogle();
                    },
                ),
                SizedBox(
                  height:Appsized.size2,
                ),
                BuildRow(
                  onTap:(){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                      return SignupScreen();
                    }));
                  },
                  text1:AppString.dontHaveAcc,
                  text2:AppString.signUp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
