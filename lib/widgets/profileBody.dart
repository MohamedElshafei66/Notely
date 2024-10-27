import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../provider/user_data.dart';
import '../screens/AuthPages/aboutApp.dart';
import '../screens/AuthPages/login_screen.dart';
import '../shared/AppColor.dart';
import '../shared/AppSized.dart';
import '../shared/AppString.dart';
import '../shared/AppStyle.dart';
import 'buildButton.dart';
import 'buildListTile.dart';
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        SizedBox(
          height:Appsized.size2,
        ),
        BuildListTile(
            onTap:(){},
            text:"${context.watch<UserDataProvider>().email}",
            icon:FontAwesomeIcons.envelope
        ),
        SizedBox(
          height:Appsized.size2,
        ),
        BuildListTile(
            onTap:(){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
                return AboutApp();
              }));
            },
            text:AppString.aboutApp,
            icon:FontAwesomeIcons.info
        ),
        SizedBox(
          height:Appsized.size2,
        ),
        BuildListTile(
            onTap:(){},
            text:AppString.profileTxt3,
            icon:FontAwesomeIcons.lock
        ),
        SizedBox(
          height:Appsized.size2,
        ),
        BuildListTile(
            onTap:(){},
            text:AppString.profileTxt4,
            icon:FontAwesomeIcons.edit
        ),
        SizedBox(
          height:Appsized.size2,
        ),
        BuildListTile(
            onTap:(){},
            text:AppString.profileTxt5,
            icon:FontAwesomeIcons.question
        ),
        SizedBox(
          height:Appsized.size2,
        ),
        BuildButton(
          onPressed:(){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.bottomSlide,
              desc:AppString.profileTxt6,
              descTextStyle:AppStyle.profileTxt2,
              btnCancelOnPress:(){},
              btnOkOnPress:()async{
                await FirebaseAuth.instance.signOut();
                GoogleSignIn google = GoogleSignIn();
                google.disconnect();
                Provider.of<UserDataProvider>(context, listen: false).clearDataUser();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder:(context) =>const LoginScreen()),
                );
              },
              btnOkColor:AppColor.forgetPassword,
              btnCancelColor:AppColor.forgetPassword,
              buttonsTextStyle:AppStyle.profileTxt3,
              dialogBackgroundColor:AppColor.scaffoldColor,
            )..show();
          },
          text:AppString.logOut,
          color:AppColor.buttonColor,
          width:400.0,
        )
      ],
    );
  }
}
