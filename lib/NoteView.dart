import 'package:flutter/material.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/archive.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/editNoteView.dart';
import 'package:google_sheets/home.dart';
import 'package:intl/intl.dart';
import 'package:google_sheets/services/db.dart';




class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});


  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.note.pin);
    print(widget.note.isArchive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.5),
        elevation: 3,
        actions: [
          ///// Pin Note ----------- 
          IconButton(
            splashRadius: 17,
              splashColor: Colors.white.withOpacity(0.7),
              onPressed: () async{
              await NotesDataBase.instance.pinNote(widget.note);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              icon: Icon(widget.note.pin ? Icons.push_pin : Icons.push_pin_outlined, color: Colors.white.withOpacity(0.7),)
          ),

          
          //// archive Note ----------- 
          IconButton(
              splashRadius: 17,
              splashColor: Colors.white.withOpacity(0.7),
              onPressed: () async{
                await NotesDataBase.instance.archiveNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(widget.note.isArchive? Icons.archive : Icons.archive_outlined, color: Colors.white.withOpacity(0.7),)
          ),

          
          //// Edit Note ------------- 
          IconButton(
              splashRadius: 17,
              splashColor: Colors.white.withOpacity(0.7),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteView(note: widget.note)));
              },
              icon: Icon(Icons.edit, color: Colors.white.withOpacity(0.7),)
          ),



          /// delete note ----------- 
          IconButton(
              splashRadius: 17,
              splashColor: Colors.white.withOpacity(0.7),
              onPressed: () async{
                await NotesDataBase.instance.deleteNote(widget.note);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                print(NotesDataBase.instance.deleteNote(widget.note));
              },
              icon: Icon(Icons.delete, color: Colors.white.withOpacity(0.7),)
          )



        ],
      ),

      body: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Created On: ${DateFormat('dd-MM-yyyy - kk:mm').format(widget.note.createdTime)}",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15
            ),
            ),

            SizedBox(height: 10,),

            Text(widget.note.title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            SizedBox(height: 7,),
            Text(widget.note.content,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 17

            ),),


          ],
        ),
      ),





    );
  }
}


