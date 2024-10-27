import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/folder_provider.dart';
import 'package:notes/provider/note_provider.dart';
import 'package:notes/provider/user_provider..dart';
import 'package:notes/screens/FolderPages/home_screen.dart';
import 'package:notes/screens/AuthPages/splash_screen.dart';
import 'package:provider/provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(
            create: (context) => UserDataProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FolderProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => NoteProvider(),
          ),
        ],
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _getInitialScreen(),
        ),
    );
  }

  Widget _getInitialScreen() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const SplashScreen();
    } else if (user.emailVerified) {
      return const HomeScreen();
    } else {
      return const SplashScreen();
    }
  }
}


