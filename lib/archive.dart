import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/NoteView.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/services/db.dart';
import 'package:google_sheets/sideMenuBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sheets/createNote.dart';



class Archive extends StatefulWidget {
 

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  bool isLoading = true;
  late List<Note> notesList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
  }


  Future getAllNotes() async{
    this.notesList = await NotesDataBase.instance.readAllArchieveNotes();
    if(this.mounted){
      setState(() {
        isLoading = false;
      });
    }
  }


  ////  -------- Notes for the home screen start ------   ////
  String note = "This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more.";
  String note1 = "This is note, this is more. This is note, this is more. This is note,";
  ////  -------- Notes for the home screen start ------   ////


  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(backgroundColor: bgColor, body: Center(child: CircularProgressIndicator(color: Colors.white.withOpacity(0.7),)),) :  Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        backgroundColor: Colors.white.withOpacity(0.7),

        child: Icon(Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),


      backgroundColor: bgColor,

       body: RefreshIndicator(
          onRefresh: (){
            return Future.delayed(Duration(seconds: 1));
            },

      child: SafeArea(

        //// -------   Main Container for all items presented in Column --  Start--------/////
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /////  --------    Search Bar Container -- Start  -------    ///////
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: cardColor,
                    boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.7), spreadRadius: 3, blurRadius: 3)],

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              icon: Icon(Icons.arrow_back_sharp,
                                color: Colors.white.withOpacity(0.7),

                              )),

                          SizedBox(width: 10,),

                          Container(
                              height: 55,
                              width: 280,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("search here",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 20

                                    ),),
                                ],
                              )
                          ),
                        ],
                      ),



                    ],
                  ),
                ),
                /////  --------    Search Bar Container -- end  -------    ///////



                ///////--- --     "All" text container start  ----------- ////////
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),

                  child: Column(
                    children: [
                      Text("All",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),

                ///////--- --     "All" text container end ----------- ////////


                SectionAll(),




              ],

            ),

          ),
        ),
        //// -------   Main Container for all items presented in Column -- end --------/////

      ),
       )

    );
  }







  /////  ----------   complete code for the all section start  ----------  ////

  Widget SectionAll(){
    return
      ///// -----------  staggered view of notes start  --------- //////
      //// --------  container number 1 of notes  ------  ////
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesList.length,
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) =>
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(note: notesList[index],)));
                    },

                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10)
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notesList[index].title,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(notesList[index].content.length > 250 ? "${notesList[index].content.substring(0,250)}.....": notesList[index].content,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),)

                        ],
                      ),

                    ),
                  ),
            ),
          ),
        ],
      );

    ///// -----------  staggered view of notes end  --------- /////
  }

/////  ----------   complete code for the all section start  ----------  ////





}














