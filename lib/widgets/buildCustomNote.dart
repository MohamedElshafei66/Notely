import 'package:flutter/material.dart';
import 'package:notes/model/note_Model.dart';
import 'package:notes/shared/AppStyle.dart';
import '../shared/AppColor.dart';
import '../shared/AppSized.dart';
// ignore: must_be_immutable
class BuildCustomNote extends StatelessWidget {
   BuildCustomNote({
    super.key,
    required this.noteModel,
    required this.editNote,
    required this.deleteNote,
  });
   final NoteModel noteModel;
   void Function()? deleteNote;
   void Function()? editNote;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:editNote,
      child: Padding(
        padding: const EdgeInsets.only(top:Appsized.size1),
        child: Card(
          clipBehavior:Clip.antiAlias,
          child:Container(
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(5)
            ),
            child: ListTile(
              tileColor:AppColor.fillColor,
              title:Text(
                "${noteModel.title}",
                style:AppStyle.titleNoteTile
              ),
              subtitle:Text(
                "${noteModel.content}",
                style:AppStyle.contentNoteTile
              ),
              trailing:GestureDetector(
                onTap:deleteNote,
                child:Icon(
                  Icons.delete,
                  color:Colors.black,
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
