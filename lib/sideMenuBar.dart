import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sheets/archive.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/createNote.dart';
import 'package:google_sheets/settings.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor
        ),

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25 ,vertical: 5),
                child: Text("Google Keep",
                  style: TextStyle(color: Colors.white.withOpacity(0.8),
                  fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Divider(
                color: Colors.white.withOpacity(0.6),
              ),

              sectionOne(),

              SizedBox(height: 5,),

              sectionTwo(),

              SizedBox(height: 5,),

              sectionthree(),




            ],
          ),
        ),


      ),
    );
  }





  //////   ---------   seection one code start -------------  ////////////
  Widget sectionOne(){
    return
      Container(
        margin: EdgeInsets.only(right: 10),

        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.3)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )
                    ))
            ),

            onPressed: () {},


            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline_rounded,
                    size: 25,
                    color: Colors.white.withOpacity(0.7),
                  ),

                  SizedBox(width: 15,),

                  Text("Notes",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20
                    ),)

                ],

              ),
            )),
      );
  }

//////   ---------   seection one code end -------------  ////////////





  //////   ---------   seection two code start -------------  ////////////
  Widget sectionTwo(){
    return
      Container(
        margin: EdgeInsets.only(right: 10),

        child: TextButton(
            style: ButtonStyle(

                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )
                    ))
            ),

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Archive()));
            },


            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.archive_outlined,
                    size: 25,
                    color: Colors.white.withOpacity(0.7),
                  ),

                  SizedBox(width: 15,),

                  Text("Archive",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20
                    ),)

                ],

              ),
            )),
      );
  }

//////   ---------   seection two code end -------------  ////////////





  //////   ---------   seection three code start -------------  ////////////
  Widget sectionthree(){
    return
      Container(
        margin: EdgeInsets.only(right: 10),

        child: TextButton(
            style: ButtonStyle(

                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        )
                    ))
            ),

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },


            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.settings,
                    size: 25,
                    color: Colors.white.withOpacity(0.7),
                  ),

                  SizedBox(width: 15,),

                  Text("Settings",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20
                    ),)

                ],

              ),
            )),
      );
  }

//////   ---------   seection three code end -------------  ////////////



}







