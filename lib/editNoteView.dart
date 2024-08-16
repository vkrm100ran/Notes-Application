import 'package:flutter/material.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/NoteView.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/services/db.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitle;
  late String NewNoteDet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDet = widget.note.content.toString();

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
                Note newNote = Note(pin: false, isArchive: false, title: NewTitle, content: NewNoteDet, createdTime: DateTime.now(), id: widget.note.id, uniqueId: widget.note.uniqueId);
                await NotesDataBase.instance.updateNote(newNote);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoteView(note: newNote)));
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
              Form(child:
                    TextFormField(
                      initialValue: NewTitle,
                      onChanged: (value){
                        NewTitle = value;
                      },
                      cursorColor: Colors.white.withOpacity(0.7),
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
                              color: Colors.white.withOpacity(0.4),
                          )
                      ),
                    ),
              ),


        
        
        
              ///// ----  second text field-------  /////
              Container(
                height: 600,
                child:
                Form(child: TextFormField(
                      initialValue : NewNoteDet,
                      onChanged: (value){
                        NewNoteDet = value;
                      },
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



              ),
        
            ],
          ),
        ),
      ),

    );
  }
}



