import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes/model/note_Model.dart';
import 'package:notes/screens/NotePages/viewNote.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import '../../helper/Db.dart';
import '../../shared/AppColor.dart';
import '../../shared/AppStyle.dart';
import '../../widgets/buildAppbar.dart';
import '../../widgets/buildButton.dart';
import '../../widgets/buildTextFormNote.dart';
class EditNote extends StatefulWidget {
  final int folderId;
  final NoteModel noteModel;
  EditNote({super.key,
    required this.noteModel,
    required this.folderId,
  });
  @override
  State<EditNote> createState() => _EditFolderState();
}
class _EditFolderState extends State<EditNote> {
  @override
  void initState() {
    titleNote.text = widget.noteModel.title;
    contentNote.text = widget.noteModel.content;
    super.initState();
  }
  Db db = Db();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController titleNote = TextEditingController();
  TextEditingController contentNote = TextEditingController();
  editNote()async{
    if(formState.currentState!.validate()){
      int response = await db.add('''
    UPDATE `notes` SET title = '${titleNote.text}' , content = '${contentNote.text}'
    WHERE idNote = ${widget.noteModel.idNote}
    ''');
      if(response > 0){
        Fluttertoast.showToast(
            msg: "Note is Edited!",
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
              return ViewNote(folderId:widget.folderId);
            }));
          },
          Icon:Icons.arrow_back,
          text:AppString.editNote
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
                    controller:titleNote,
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
                    controller:contentNote,
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
                    await editNote();
                  },
                  text:AppString.editNote,
                  color:AppColor.buttonColor,
                  width:200.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
