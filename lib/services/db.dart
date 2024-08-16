import 'dart:io';

import 'package:google_sheets/Model/myNoteModel.dart';
import 'package:google_sheets/services/firebase_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class NotesDataBase{
  static const dbName = "Notes.db";
  static const dbVersion = 6;
  static const dbTable = "myDatabase";
  static const columnId = "id";
  static const columnName = "name";



  //// make a instance of the object by the help of this we access the data inside the class---
  static final NotesDataBase instance = NotesDataBase();

  //// initialize database from the sqflite package and store into _database variable--
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    return await openDatabase(path, version: dbVersion, onCreate: _CreateDB);
  }

  //// onCreate method ---
  Future _CreateDB(Database db, int version) async {
    //// here we make two new variables for the which is db and version, because onCreate method is always take two parameters--
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute(
        '''
      CREATE TABLE ${NoteImpNames.tableName}(
      ${NoteImpNames.id} $idType,
      ${NoteImpNames.pin} $boolType,
      ${NoteImpNames.isArchive} $boolType,
      ${NoteImpNames.title} $textType,
      ${NoteImpNames.uniqueId} $textType,
      ${NoteImpNames.content} $textType,
      ${NoteImpNames.createdTime} $textType
      )  
      '''
    );
  }

    ////  ---------  function for insert data - -
    Future<Note> insertRecord(Note note) async{
    await FireDB().createNewNoteFirestore(note);
      final db = await instance.database;
      final id = await db!.insert(NoteImpNames.tableName, note.toJson());
      return note.copy(id: id);
    }


    ////  -----  function for read all data and print
    Future <List<Note>> readAllNotes() async{
    final db = await instance.database;
    final orderBy = '${NoteImpNames.createdTime} ASC';
    final List<Map<String, dynamic>> records = await db!.query(NoteImpNames.tableName, orderBy: orderBy);
    print(records);
    return records.map((json) => Note.fromJson(json)).toList();
    }



  ////  -----  function for read all archieve data and print
  Future <List<Note>> readAllArchieveNotes() async{
    final db = await instance.database;
    final orderBy = '${NoteImpNames.createdTime} ASC';
    final List<Map<String, dynamic>> records = await db!.query(NoteImpNames.tableName, orderBy: orderBy, where: '${NoteImpNames.isArchive} = 1');
    print(records);
    return records.map((json) => Note.fromJson(json)).toList();
  }





    ////   --------  function for the read and print only one data
    Future<Note?> readOneNote(int id) async{
    final db = await instance.database;
    final map = await db!.query(NoteImpNames.tableName,
    columns: NoteImpNames.values,
      where: '${NoteImpNames.id} = ?',
      whereArgs: [id]
    );
    if(map.isNotEmpty){
      return Note.fromJson(map.first);
    }else{
      return null;
    }
    }


    ////  ----- --  function for update data from the data--
    Future updateNote(Note note) async{
    await FireDB().updateNoteFirestore(note);
    final db = await instance.database;
    final updateData = await db!.update(NoteImpNames.tableName, note.toJson(), where: '${NoteImpNames.id} = ?', whereArgs: [note.id]);
    print(updateData);
    return updateData;
    }

    //// -------- function for delete data from the database
    Future deleteNote(Note note) async{
    await FireDB().deleteNoteFirestore(note);
    final db = await instance.database;
    final deletedata = await db!.delete(NoteImpNames.tableName, where: '${NoteImpNames.id} = ?', whereArgs: [note.id]);
    print(deletedata);
    }



  ////  ----- --  function for pin data from the data--
  Future pinNote(Note note) async{
    final db = await instance.database;
    final updateData = await db!.update(NoteImpNames.tableName, {NoteImpNames.pin : !note.pin ? 1:0 }, where: '${NoteImpNames.id} = ?', whereArgs: [note.id]);
    print(updateData);
    return updateData;
  }



  ////  ----- --  function for archive data from the data--
  Future archiveNote(Note note) async{
    final db = await instance.database;
    final updateData = await db!.update(NoteImpNames.tableName, {NoteImpNames.isArchive : !note.isArchive ? 1:0 }, where: '${NoteImpNames.id} = ?', whereArgs: [note.id]);
    print(updateData);
    return updateData;
  }





    //// ------ getNoteString function ----
    Future<List<int>> getNoteString(String query) async{
    final db = await instance.database;
    final result = await db!.query(NoteImpNames.tableName);

    List<int> resultIds = [];
    result.forEach((element) {
      String title = element["title"].toString().toLowerCase();
      String content = element["content"].toString().toLowerCase();

      if(title.contains(query.toLowerCase()) || content.contains(query.toLowerCase())){
        resultIds.add(element["id"] as int);
      }
    }) ;
    print("$resultIds these are result ids" );
    return resultIds;
    }



  // Future<List<int>> getNoteString(String query) async {
  //   final db = await instance.database;
  //   final result = await db!.rawQuery(
  //       'SELECT id, title, content FROM Note5 WHERE title LIKE ? OR content LIKE ?',
  //       ['%$query%', '%$query%']
  //   );
  //   List<int> resultIds = [];
  //   result.forEach((element) {
  //     resultIds.add(element['id'] as int);
  //   });
  //   print(resultIds);
  //   return resultIds;
  //}


  ////  -------- function for close database
  Future closeDB() async{
    final db = await instance.database;
    db!.close();
  }



}






