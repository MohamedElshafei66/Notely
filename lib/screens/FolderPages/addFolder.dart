import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/helper/Db.dart';
import 'package:notes/screens/FolderPages/home_screen.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/widgets/buildAppbar.dart';
import 'package:notes/widgets/buildButton.dart';
import 'package:notes/widgets/buildTextForm.dart';
import '../../shared/AppColor.dart';
class AddFolder extends StatefulWidget {
  const AddFolder({super.key});

  @override
  State<AddFolder> createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  Db db = Db();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController folderName = TextEditingController();
  addFolder() async {
    if (formState.currentState!.validate()) {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isNotEmpty) {
        int response = await db.add('''
          INSERT INTO `folders` (`folder`, `userId`)
          VALUES ('${folderName.text}', '$userId')
        ''');
        if (response > 0) {
          Fluttertoast.showToast(
              msg: "Folder is Added!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColor.fillColor,
              textColor: AppColor.cursorColor,
              fontSize: 16.0
          );
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.scaffoldColor,
      appBar:BuildAppBar(
          onTap:(){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context){
              return HomeScreen();
            }));
          },
          Icon:Icons.arrow_back,
          text:AppString.addFolder
      ),
      body:Form(
        key:formState,
        child: Padding(
          padding: const EdgeInsets.only(left:Appsized.size1,right:Appsized.size1,top:Appsized.size7),
          child: Column(
            children:[
              BuildTextForm(
                  maxLength:10,
                  validator:(text){
                    if(text == null || text.isEmpty){
                      return "this field shouldn't be empty";
                    }
                    return null;
                  },
                  prefixIcon:FontAwesomeIcons.folderOpen,
                  controller:folderName,
                  hint:"Folder Name",
                  lines:1
              ),
              SizedBox(
                height:Appsized.size2,
              ),
              BuildButton(
                  onPressed:()async{
                    await addFolder();
                  },
                  text:AppString.addFolder,
                  color:AppColor.buttonColor,
                  width:200.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
