import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes/provider/note_provider.dart';
import 'package:notes/screens/FolderPages/home_screen.dart';
import 'package:notes/screens/NotePages/addNote.dart';
import 'package:notes/screens/NotePages/editNote.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/widgets/buildAppbar.dart';
import 'package:notes/widgets/buildCustomNote.dart';
import '../../core/utils/image_Manger.dart';
import '../../shared/AppColor.dart';
import '../../shared/AppStyle.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({super.key, required this.folderId});
  final int folderId;

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoteProvider>(context, listen: false).viewNotes(widget.folderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar:BuildAppBar(
          onTap:(){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
            );
          },
          Icon:Icons.arrow_back,
          text:AppString.recentNote
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.fillColor,
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return AddNote(folderId: widget.folderId);
            }),
          );
        },
        child: Icon(
          Icons.add,
          color: AppColor.buttonColor,
          size: 40,
        ),
      ),
      body: noteProvider.loading
          ? Center(
           child: CircularProgressIndicator(
           color: AppColor.forgetPassword,
        ),
      )
          : Padding(
           padding: const EdgeInsets.symmetric(horizontal: Appsized.size6),
            child: SingleChildScrollView(
             child: Column(
             children: [
              if (notes.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: Appsized.size8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image(
                          image: AssetImage("${ImageManger.note}"),
                          height: 180,
                          width: 180,
                        ),
                      ),
                      SizedBox(
                        height: Appsized.size6,
                      ),
                      Text(
                        AppString.nonNotes,
                        style: AppStyle.folderStyle,
                      ),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: Appsized.size2),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:notes.length,
                    itemBuilder: (context, i) {
                      return BuildCustomNote(
                        noteModel:notes[i],
                        editNote: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return EditNote(
                                  noteModel:notes[i],
                                  folderId: widget.folderId,
                                );
                              },
                            ),
                          );
                        },
                        deleteNote: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.noHeader,
                            animType: AnimType.bottomSlide,
                            desc: AppString.deleteNote,
                            descTextStyle: AppStyle.profileTxt2,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              await noteProvider.deleteNote(notes[i].idNote.toString());
                            },
                            btnOkColor: AppColor.forgetPassword,
                            btnCancelColor: AppColor.forgetPassword,
                            buttonsTextStyle: AppStyle.profileTxt3,
                            dialogBackgroundColor: AppColor.scaffoldColor,
                          )..show();
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
