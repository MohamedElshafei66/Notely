import 'package:flutter/material.dart';
import 'package:notes/core/utils/image_Manger.dart';
import 'package:notes/screens/AuthPages/login_screen.dart';
import 'package:notes/shared/AppColor.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildButton.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      body:Container(
        width:double.infinity,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            SizedBox(
              height:Appsized.size4,
            ),
            Image.asset(
                "${ImageManger.onBoarding}"
            ),
            SizedBox(
              height:Appsized.size2,
            ),
            Center(
              child: Text(
                AppString.text1,
                style:AppStyle.text1
              ),
            ),
            SizedBox(
              height:Appsized.size1,
            ),
            Center(
              child: Text(
               AppString.text2,
                style:AppStyle.text2
              ),
            ),
            SizedBox(
              height:Appsized.size3,
            ),
            Padding(
              padding: const EdgeInsets.only(right:Appsized.size1,left:Appsized.size1),
              child: BuildButton(
                  onPressed:()async{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                      return LoginScreen();
                    }));
                  },
                  text:AppString.text3,
                  width:400.0,
                  color:AppColor.buttonColor,
              )
            ),
          ],
        ),
      ),
    );
  }
}
