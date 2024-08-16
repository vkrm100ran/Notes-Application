import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sheets/home.dart';
import 'package:google_sheets/services/auth.dart';
import 'package:google_sheets/services/constant.dart';
import 'package:google_sheets/services/firebase_db.dart';
import 'package:google_sheets/services/localdb.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
signInMethod(context) async{
  await signInWithGoogle();
  print("google authentication is successful ... ");

  constant.name = (await LocalDataSaver.getName())!;
  constant.email = (await LocalDataSaver.getEmail())!;
  constant.img = (await LocalDataSaver.getImg())!;

  print("Name = ${constant.name}, email = ${constant.email}, img = ${constant.img}");

  await FireDB().getAllStoredNotes();

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login To App"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google,
                onPressed: (){
              signInMethod(context);

                })
          ],
        ),
      ),

    );
  }
}




