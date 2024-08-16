import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/NoteView.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/searchView.dart';
import 'package:google_sheets/services/auth.dart';
import 'package:google_sheets/services/db.dart';
import 'package:google_sheets/services/firebase_db.dart';
import 'package:google_sheets/services/localdb.dart';
import 'package:google_sheets/services/login.dart';
import 'package:google_sheets/sideMenuBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sheets/createNote.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  bool isLoading = true;

  late String? imgUrl;

  //// ---- List of Notes ----
  late List<Note> notesList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     //createEntry(Note(pin: false, isArchive: false, title: "Test Files", content: "asdvbe asbfkj asjbda  bajksdb nbdj sajkb dajbk cjkb dasjb asjb asjb  test files these are test files that are test files, these are test files", createdTime: DateTime.now()));
     getAllNotes();
     //FireDB().getAllStoredNotes();
    // //getOneNote();
    // //getUpdateNote();
    // getDeleteData();
    // getUpdateNote();
    // getOneNote();

  }


//// ----------  Function for insert data start -----   /////
  Future createEntry(Note note) async{
    await NotesDataBase.instance.insertRecord(note);
  }
  //// ----------  Function for insert data end -----   /////



  //// ----------  Function for print all data start -----   /////
  Future getAllNotes() async{
    LocalDataSaver.getImg().then((value){
      if(this.mounted){
        setState(() {
          imgUrl = value;
        });
      }
    });

    this.notesList = await NotesDataBase.instance.readAllNotes();
    if(this.mounted){
      setState(() {
        isLoading = false;
      });
    }
  }

  //// ----------  Function for print data end -----   /////



  //// ----------  Function for print a single start -----   /////
  Future getOneNote(int id) async{
    await NotesDataBase.instance.readOneNote(id);
  }
  //// ----------  Function for print a single data end -----   /////



  //// ----------  Function for update data start -----   /////
  Future getUpdateNote(Note note) async{
    await NotesDataBase.instance.updateNote(note);
  }
  //// ----------  Function for update data end -----   /////



//================this method to delete  entry
//   Future getDeleteData(Note note) async{
//     await NotesDataBase.instance.deleteNote(note);
//   }








  ////   -----  global key for the drawer start  -------  ////
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  ////   -----  global key for the drawer start  -------  ////


  ////  -------- Notes for the home screen start ------   ////
  String note = "This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more.";
  String note1 = "This is note, this is more. This is note, this is more. This is note,";
  ////  -------- Notes for the home screen start ------   ////


  //// isStaggered ---
  bool isStaggered = true;


  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(backgroundColor: bgColor, body: Center(child: CircularProgressIndicator(color: Colors.white.withOpacity(0.7),)),) : Scaffold(
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

      endDrawerEnableOpenDragGesture: true,
      key: _drawerKey,
      drawer: SideMenu(),

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
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                              _drawerKey.currentState!.openDrawer();
                            },
                                icon: Icon(Icons.menu,
                                  color: Colors.white.withOpacity(0.7),

                                )),

                            SizedBox(width: 10,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
                              },

                              child: Container(
                                height: 55,
                                  width: MediaQuery.of(context).size.width/3,

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
                            ),
                          ],
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),


                          child: Row(
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    )
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      isStaggered = !isStaggered;
                                    });
                                  },
                                  child: Icon(Icons.grid_view,
                                    color: Colors.white.withOpacity(0.7),

                                  )),

                              SizedBox(width: 9,),

                              GestureDetector(
                                onTap: (){
                                  signOut();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: CircleAvatar(
                                  onBackgroundImageError: (Object, StackTrace){
                                    print("ok");
                                  },
                                  radius: 17,
                                  backgroundImage: NetworkImage(imgUrl.toString()),
                                ),
                              )

                            ],
                          ),
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


                  isStaggered ? SectionAll() : SectionAllList()



                ],

              ),

            ),
          ),
          //// -------   Main Container for all items presented in Column -- end --------/////

        ),
      ),

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(note: notesList[index]))
                      );
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








////   ---------  widget for section list ---------  ////
  Widget SectionAllList(){
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 15),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notesList.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10),
                color: index.isEven ? Colors.green.withOpacity(0.4) : Colors.blue.withOpacity(0.3)
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
      );
  }
////   ---------  widget for section list end ---------  ////






}














