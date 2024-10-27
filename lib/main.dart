import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyApp.dart';
import 'firebase_options.dart';
late SharedPreferences shared;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

