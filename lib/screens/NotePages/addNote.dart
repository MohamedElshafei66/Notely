import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/helper/Db.dart';
import 'package:notes/screens/NotePages/viewNote.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildButton.dart';
import 'package:notes/widgets/buildTextFormNote.dart';
import '../../shared/AppColor.dart';
import '../../shared/AppSized.dart';
import '../../widgets/buildAppbar.dart';
class AddNote extends StatefulWidget {
  const AddNote({super.key,required this.folderId});
  final int folderId;
  @override
  State<AddNote> createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote> {
  Db db = Db();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  addFolder(int folderId) async {
    if (formState.currentState!.validate()) {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (userId.isNotEmpty) {
        int response = await db.add('''
          INSERT INTO `notes` (`title`, `content`, `userId` , `folderId`)
          VALUES ('${title.text}', '${content.text}' ,'$userId' , $folderId)
        ''');
        if (response > 0) {
          Fluttertoast.showToast(
              msg: "Note is Added!",
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
              return ViewNote(folderId:widget.folderId,);
            }));
          },
          Icon:Icons.arrow_back,
          text:AppString.addNote
      ),
      body:Form(
        key:formState,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:Appsized.size6,right:Appsized.size6),
            child: Column(
              children:[
                BuildTextFormNote(
                    hint:AppString.titleNote,
                    maxLines:1,
                    maxLength:20,
                    controller:title,
                   validator:(text){
                    if(text == null || text.isEmpty){
                      return "You must enter title";
                    }
                    return null;
                  },
                   style:AppStyle.titleNoteStyle
                ),
                BuildTextFormNote(
                  hint:AppString.contentNote,
                  maxLines:10,
                  maxLength:1000,
                  controller:content,
                  validator:(text){
                    if(text == null || text.isEmpty){
                      return "You must enter content";
                    }
                    return null;
                  },
                  style:AppStyle.contentNoteStyle
                ),
                SizedBox(
                  height:Appsized.size7,
                ),
                BuildButton(
                    onPressed:()async{
                      await addFolder(widget.folderId);
                    },
                    text:AppString.addNote,
                    color:AppColor.buttonColor,
                    width:150.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
