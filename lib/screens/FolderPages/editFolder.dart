import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import '../../helper/Db.dart';
import '../../model/folder_Model.dart';
import '../../shared/AppColor.dart';
import '../../widgets/buildAppbar.dart';
import '../../widgets/buildButton.dart';
import '../../widgets/buildTextForm.dart';
import 'home_screen.dart';
class EditFolder extends StatefulWidget {
  final Folder folderModel;
   EditFolder({super.key,required this.folderModel});
  @override
  State<EditFolder> createState() => _EditFolderState();
}
class _EditFolderState extends State<EditFolder> {
  @override
  void initState() {
    folderName.text = widget.folderModel.folderName;
    super.initState();
  }
  Db db = Db();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController folderName = TextEditingController();
  editFolder()async{
    if(formState.currentState!.validate()){
      int response = await db.add('''
    UPDATE `folders` SET folder = '${folderName.text}'
    WHERE id = ${widget.folderModel.id}
    ''');
      if(response > 0){
        Fluttertoast.showToast(
            msg: "Folder is Edited!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:AppColor.fillColor,
            textColor:AppColor.cursorColor,
            fontSize: 16.0
        );
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
          text:AppString.editFolder
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
                  await editFolder();
                },
                text:AppString.editFolder,
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
