import 'package:flutter/material.dart';
import 'package:notes/model/folder_Model.dart';
import '../core/utils/image_Manger.dart';
import '../shared/AppColor.dart';
import '../shared/AppStyle.dart';
// ignore: must_be_immutable
class FolderCard extends StatelessWidget {
   FolderCard({
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.onDoubleTap,
    required this.folderModel
  });
  void Function()? onTap;
  void Function()? onLongPress;
  void Function()? onDoubleTap;
  Folder folderModel;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap,
      onLongPress:onLongPress,
      onDoubleTap:onDoubleTap,
      child: Card(
        child:Container(
          decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              color:AppColor.fillColor
          ),
          child:Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Center(
                child:Image(
                  image:AssetImage("${ImageManger.folder}"),
                  fit:BoxFit.cover,
                ),
              ),
              Text(
                  "${folderModel.folderName}",
                  style:AppStyle.folderName
              ),
            ],
          ),
        ),
      ),
    );
  }
}
