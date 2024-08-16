import 'package:flutter/material.dart';
import 'package:google_sheets/colors.dart';
import 'package:google_sheets/services/localdb.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late bool value = false;

  getSyncSet() async{
    LocalDataSaver.getSyncSetting().then((valueFromLocaldb){
      setState(() {
        value = valueFromLocaldb!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSyncSet();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.7),
        elevation: 3,
        title: Text("Settings"),

      ),


      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Text("Sync",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 21
                  ),
                ),
                Spacer(),
                Transform.scale(scale: 1.3,),
                Switch.adaptive(value: value, onChanged: (switchValue){
                  setState(() {
                    this.value = switchValue;
                    LocalDataSaver.saveSyncSetting(switchValue);
                  });
                })
              ],
            )
          ],
        ),
      ),


    );
  }
}






