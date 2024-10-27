import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/provider/user_data.dart';
import 'package:notes/screens/FolderPages/home_screen.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildAppbar.dart';
import 'package:notes/widgets/profileBody.dart';
import 'package:provider/provider.dart';
import '../../shared/AppColor.dart';
import '../../widgets/buildGetureDetector.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  File? file;
  Future<void> getImagePic(BuildContext context, String email) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageAcc = await picker.pickImage(source: ImageSource.gallery);
    if (imageAcc != null) {
      Provider.of<UserDataProvider>(context, listen: false).setImagePath(email, imageAcc.path);
    }
  }
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final String email = userDataProvider.email;
    final String? imageProfile = userDataProvider.imagePath;
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      appBar:BuildAppBar(
          onTap:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
              return HomeScreen();
            }));
          },
          Icon:Icons.arrow_back,
          text:AppString.profileTxt1
      ),
      body:Padding(
        padding:EdgeInsets.only(left:Appsized.size6,right:Appsized.size6),
        child: SingleChildScrollView(
          child:Column(
            children:[
               SizedBox(
                 height:Appsized.size1,
               ),
              if (imageProfile != null)
                 Center(
                    child:Stack(
                      alignment:Alignment.bottomRight,
                      children:[
                        Container(
                          clipBehavior:Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            child:Image.file(
                              File(imageProfile),
                              fit:BoxFit.fill,
                            ),
                            radius:70,
                          ),
                        ),
                        CircleAvatar(
                          child:BuildGetureDetector(
                              onTap:()async{
                                await getImagePic(context,email);
                              },
                              icon:Icons.camera_alt_outlined,
                              color:Colors.white,
                              size:25
                          ),
                          backgroundColor:Colors.black,
                        ),
                      ],
                    )
                )
                 else
                 Center(
                    child:Stack(
                      alignment:Alignment.bottomRight,
                      children:[
                        CircleAvatar(
                          child:Icon(
                            Icons.person,
                            size:80,
                            color:AppColor.forgetPassword,
                          ),
                          radius:70,
                          backgroundColor:AppColor.fillColor,
                        ),
                        CircleAvatar(
                          child:BuildGetureDetector(
                              onTap:()async{
                                await getImagePic(context,email);
                              },
                              icon:Icons.camera_alt_outlined,
                              color:Colors.white,
                              size:25
                          ),
                          backgroundColor:Colors.black,
                        ),
                      ],
                    )
                ),
                 SizedBox(
                height:Appsized.size2,
              ),
                 Text(
                "${context.watch<UserDataProvider>().userName}",
                style:AppStyle.profileTxt1
              ),
                 ProfileBody(),
            ],
          ),
        ),
      ),
    );
  }
}



