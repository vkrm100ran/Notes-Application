import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver{
  static String nameKey = "nameKey";
  static String imgKey = "imgKey";
  static String emailKey = "emailKey";
  static String logKey = "logKey";
  static String syncKey = "syncKey";


  ////  ------store name in local storage  -----
  static Future<bool> saveName(String username) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, username);
  }


  ////  ------store email in local storage  -----
  static Future<bool> saveEmail(String useremail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(emailKey, useremail);
  }


  ////  ------store img in local storage  -----
  static Future<bool> saveImg(String userimg) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(imgKey, userimg);
  }


  ////  ------store sync setting in local storage  -----
  static Future<bool> saveSyncSetting(bool isSyncOn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(syncKey, isSyncOn);
  }







  ////  ------------- get name, mail, img from the storage --
  static Future<String?> getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nameKey);
  }

  static Future<String?> getEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(emailKey);
  }

  static Future<String?> getImg() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(imgKey);
  }

  //// ---- access sync setting --
  static Future<bool?> getSyncSetting() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(syncKey);
  }






  //////   -------- saveLogin data in storage ----
  static Future<bool> saveLoginData(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn);
  }


  //// ---- access loginstate --
  static Future<bool?> getLogData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(logKey);
  }




}









