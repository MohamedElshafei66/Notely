import 'package:flutter/material.dart';
// ignore: must_be_immutable
class BuildGetureDetector extends StatefulWidget {
  void Function()? onTap;
  IconData icon;
  Color color;
  double size;
   BuildGetureDetector({
     super.key,
     required this.onTap,
     required this.icon,
     required this.color,
     required this.size
   });
  @override
  State<BuildGetureDetector> createState() => _BuildGetureDetectorState();
}
class _BuildGetureDetectorState extends State<BuildGetureDetector> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:widget.onTap,
      child: Icon(
        widget.icon,
        color:widget.color,
        size:widget.size,
      ),
    );
  }
}
