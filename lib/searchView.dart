
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_sheets/NoteView.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/services/db.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  ////  -------- Notes for the home screen start ------   ////
  String note = "This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more. This is note, this is more.";
  String note1 = "This is note, this is more. This is note, this is more. This is note,";
  ////  -------- Notes for the home screen start ------   ////



  List<Note> searchResultsNotes = [];

  bool isLoading = false;
  void searchResults(String query) async{
    setState(() {
      isLoading = true;
    });

    try{
    final  ResultIds = await NotesDataBase.instance.getNoteString(query);
    setState(() {
      searchResultsNotes.clear();
    });
    print("${ResultIds}   these are result ids --- -" );

    // List<Note?> SearchResultNotesLocal = [];
    ResultIds.forEach((element) async{
      final SearchNote = await NotesDataBase.instance.readOneNote(element);
      //SearchResultNotesLocal.add(SearchNote);
      //setState(() {
        searchResultsNotes.add(SearchNote!);
        print(searchResultsNotes);
      //});
    });


    // await (ResultIds.map((element) async{
    //   final searchNote = await NotesDataBase.instance.readOneNote(element);
    //   setState(() {
    //     searchResultsNotes.add(searchNote!);
    //   });
    // }));

    // await Future.forEach(ResultIds, (int id) async {
    //   final searchNote = await NotesDataBase.instance.readOneNote(id);
    //
    //   if (searchNote != null) {
    //      //setState(() {
    //       searchResultsNotes.add(searchNote);
    //      //});
    //   }
    // });
    } catch(e){
      print("$e    ----  this is error ------------");
    };


    setState(() {
      isLoading = false;
      print('$searchResultsNotes this is searchResultsNotes List' );
    });



  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1)
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
            
                          icon: Icon(Icons.arrow_back,
                            color: Colors.white.withOpacity(0.7),
                          )),
            
            
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value){
                            setState(() {
                              searchResults(value.toLowerCase());
                            });
                          },
            
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Your Notes ",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 20
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                isLoading ? Center(child: CircularProgressIndicator(color: Colors.white.withOpacity(0.7),)) :
                SectionAll()
              ],
            ),
          ),
        ),
      ),


    );
  }



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
              itemCount: searchResultsNotes.length,
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) =>
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NoteView(note: searchResultsNotes[index]))
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
                          Text(searchResultsNotes[index].title,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 7,),
                          Text(searchResultsNotes[index].content.length > 250 ? "${searchResultsNotes[index].content.substring(0,250)}.....": searchResultsNotes[index].content,
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


