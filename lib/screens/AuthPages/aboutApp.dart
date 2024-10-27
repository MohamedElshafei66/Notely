import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/screens/NotePages/profile_screen.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import '../../core/utils/image_Manger.dart';
import '../../shared/AppColor.dart';
import '../../widgets/buildAppbar.dart';
class AboutApp extends StatefulWidget {
  const AboutApp({super.key});
  @override
  State<AboutApp> createState() => _AboutAppState();
}
class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      appBar:BuildAppBar(
          onTap:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
              return ProfileScreen();
            }));
          },
          Icon:Icons.arrow_back,
          text:AppString.aboutApp
      ),
      body:Padding(
        padding: const EdgeInsets.only(left:Appsized.size6,right:Appsized.size6),
        child: SingleChildScrollView(
          child: Column(
            children:[
              Image.asset(
                "${ImageManger.logoNative}",
                height:150,
              ),
              Text(
                AppString.aboutTxt1,
                style:AppStyle.aboutAppTxt1
              ),
              Text(
                AppString.aboutTxt2,
                style:AppStyle.aboutAppTxt2
              ),
              SizedBox(
                height:Appsized.size1,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Text(
                    AppString.aboutTxt3,
                    style:AppStyle.aboutAppTxt3
                  ),
                  SizedBox(
                    width:Appsized.size1,
                  ),
                  FaIcon(
                    FontAwesomeIcons.fire,
                    color:AppColor.buttonColor,
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
