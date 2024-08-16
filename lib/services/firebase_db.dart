import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/services/db.dart';
import 'package:google_sheets/services/localdb.dart';

class FireDB {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //// create a function for the add data in firebase---
  createNewNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSetting().then((isSyncOn) async{
      if(isSyncOn ?? true){
        final User? current_user = auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes1")
            .doc(current_user!.email)
            .collection("UserNotes")
            .doc(note.uniqueId)
            .set({
          "title": note.title,
          "content": note.content,
          "uniqueId": note.uniqueId,
          "date": note.createdTime
        }).then((_) {
          print("data is added successfully");
        });
      };
    });

  }




  //// create function for get notes stored in firestore ---
  getAllStoredNotes() async {
    final User? current_user = auth.currentUser;
    //try {
    await FirebaseFirestore.instance
        .collection("notes1")
        .doc(current_user!.email.toString())
        .collection("UserNotes")
        .orderBy("date")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Map note = result.data();
        print("${note} this is data of the firebase .... ");

        NotesDataBase.instance.insertRecord(Note(
            pin: false,
            isArchive: false,
            uniqueId: note["uniqueId"],
            title: note["title"],
            content: note["content"],
            createdTime: note["date"].toDate()));
      });
    });
    // } catch (e) {
    //   print("this is erro -------  ..........    $e");
    // }
  }





  // create function for update data thats already store in firebase ----
  updateNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSetting().then((isSyncOn) async {
      if (isSyncOn ?? true) {
        final User? current_user = auth.currentUser;
        await FirebaseFirestore.instance.collection("notes1").doc(current_user!.email.toString()).collection("UserNotes").doc(note.uniqueId).update({
          "title": note.title.toString(),
          "content": note.content.toString(),
        }).then((_) {
          //print("title : ${note.title}, content : ${note.content}, gmail : ${current_user.email}");
          print("data is updated successfully");
        });
      }
      ;
    });
  }





  //// create function for the delete data that store in firebase- --
  deleteNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSetting().then((isSyncOn) async{
      if(isSyncOn ?? true){
        final User? current_user = auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes1")
            .doc(current_user!.email.toString())
            .collection("UserNotes")
            .doc(note.uniqueId)
            .delete()
            .then((_) {
          print("data is deleted successfully");
        });
      };
    });

  }


}
