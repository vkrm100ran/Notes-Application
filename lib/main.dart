

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sheets/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sheets/services/firebase_db.dart';
import 'package:google_sheets/services/localdb.dart';
import 'package:google_sheets/services/constant.dart';
import 'package:google_sheets/services/login.dart';



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print("initializing firebase");
  Platform.isAndroid? await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC8B_ov9tMba94Fl-1av1iVdN9X-UqFeoY",
        appId: "1:962206102996:android:5e4feaafddf2cd8e6b9241",
        messagingSenderId: "962206102996",
        projectId: "keep-notes-cf7a5"
    )
  ) : await Firebase.initializeApp();

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Authentication(),
    );
  }
}

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInState();
  }

  bool isLogin = false;

  getLoggedInState() async{
    await LocalDataSaver.getLogData().then((value){
      setState(() {
        isLogin = value!;
      });
    });

    constant.name = (await LocalDataSaver.getName())!;
    constant.email = (await LocalDataSaver.getEmail())!;
    constant.img = (await LocalDataSaver.getImg())!;
    FireDB().getAllStoredNotes();
  }


  @override
  Widget build(BuildContext context) {
    return isLogin? Home() : Login();
  }
}




