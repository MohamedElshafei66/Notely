import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/core/utils/image_Manger.dart';
import 'package:notes/provider/user_provider..dart';
import 'package:notes/screens/FolderPages/addFolder.dart';
import 'package:notes/screens/FolderPages/editFolder.dart';
import 'package:notes/screens/NotePages/profile_screen.dart';
import 'package:notes/screens/NotePages/viewNote.dart';
import 'package:notes/shared/AppSized.dart';
import 'package:notes/shared/AppString.dart';
import 'package:notes/shared/AppStyle.dart';
import 'package:notes/widgets/buildGetureDetector.dart';
import 'package:notes/widgets/buildCustomFolder.dart';
import 'package:provider/provider.dart';
import '../../provider/folder_provider.dart';
import '../../shared/AppColor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String email = FirebaseAuth.instance.currentUser?.email ?? '';
      if (email.isNotEmpty) {
        Provider.of<UserDataProvider>(context, listen: false).loadDataUser(email);
      }
      Provider.of<FolderProvider>(context, listen: false).getFolders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final folderProvider = Provider.of<FolderProvider>(context);
    final folders = folderProvider.folders;
    final loading = folderProvider.loading;

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.fillColor,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return const AddFolder();
          }));
        },
        child: Icon(
          Icons.add,
          color: AppColor.buttonColor,
          size: 40,
        ),
      ),
      body: loading
          ? Center(
           child: CircularProgressIndicator(
            color: AppColor.forgetPassword,
        ),
      )
          : Padding(
           padding: const EdgeInsets.only(left: Appsized.size6, right: Appsized.size6),
           child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: Appsized.size7),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(AppString.welcomeText, style: AppStyle.homeTxt1),
                      Text(
                        "${context.watch<UserDataProvider>().userName}",
                        style: AppStyle.homeTxt2,
                      ),
                    ],
                  ),
                  Spacer(),
                  BuildGetureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                        return const ProfileScreen();
                      }));
                    },
                    icon: Icons.person,
                    color: AppColor.buttonColor,
                    size: 40,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                      AppString.folders,
                      style: AppStyle.folderStyle
                  ),
                  Spacer(),
                  SizedBox(height: Appsized.size4),
                  FaIcon(
                    FontAwesomeIcons.folderOpen,
                    color: AppColor.buttonColor,
                    size: 30,
                  )
                ],
              ),
              if (folders.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: Appsized.size3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(ImageManger.homeImage),
                      ),
                      Text(
                          AppString.nonNotesTxt,
                          style: AppStyle.folderStyle
                      ),
                    ],
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: folders.length,
                  itemBuilder: (context, i) {
                    return FolderCard(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return EditFolder(folderModel: folders[i]);
                        }));
                      },
                      onLongPress: (){
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.bottomSlide,
                          desc: AppString.deleteFolder,
                          descTextStyle: AppStyle.profileTxt2,
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await folderProvider.deleteFolder(folders[i].id.toString());
                          },
                          btnOkColor: AppColor.forgetPassword,
                          btnCancelColor: AppColor.forgetPassword,
                          buttonsTextStyle: AppStyle.profileTxt3,
                          dialogBackgroundColor: AppColor.scaffoldColor,
                        ).show();
                      },
                      onDoubleTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                          return ViewNote(folderId: folders[i].id!);
                        }));
                      },
                      folderModel: folders[i],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
