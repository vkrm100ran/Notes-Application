import 'package:flutter/material.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/home.dart';
import 'package:google_sheets/services/db.dart';
import 'package:uuid/uuid.dart';

class CreateNote extends StatefulWidget {

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  var uuid = Uuid();

  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.5),
        elevation: 3,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async{
                await NotesDataBase.instance.insertRecord(Note(pin: false, isArchive: false, uniqueId: uuid.v1(), title: title.text, content: content.text, createdTime: DateTime.now()));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.save_outlined,
                color: Colors.white.withOpacity(0.7),
                size: 28,
              ))
        ],
      ),


      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                cursorColor: Colors.white.withOpacity(0.7),
                controller: title,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white.withOpacity(0.7)
                ),

                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Tittle",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.4)
                    )
                ),
              ),



              ///// ----  second text field-------  /////
              Container(
                height: 600,
                child: TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  cursorColor: Colors.white.withOpacity(0.7),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 25
                  ),

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Enter Text Here .. ",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.4),
                      )


                  ),


                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}





