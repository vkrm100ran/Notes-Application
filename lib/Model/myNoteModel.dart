

class NoteImpNames{
  static final id = "id";
  static final uniqueId = "uniqueId";
  static final pin = "pin";
  static final isArchive = "isArchive";
  static final title = "title";
  static final content = "content";
  static final createdTime = "createdTime";
  static final tableName = "Note9";

  static final List<String> values = [id, pin, isArchive, title, content, createdTime];
}




class Note{
 final int? id;
 final bool pin;
 final bool isArchive;
 final String title;
 final String uniqueId;
 final String content;
 final DateTime createdTime;

 //// ---- constructor for Note class --
 const Note({
   this.id,
   required this.pin,
   required this.isArchive,
   required this.title,
   required this.uniqueId,
   required this.content,
   required this.createdTime,
});


 ////  --- constructor for copy the data--  its means that when we click on save button then our data will save and if we open a note and edit it and after that we save it then, for this we use copy constructor ----
 Note copy({
   int? id,
   bool? pin,
   bool? isArchive,
   String? title,
   String? uniqueId,
   String? content,
   DateTime? createdTime,
}){
   return Note(id: id ?? this.id,
       pin: pin ?? this.pin,
       isArchive: isArchive ?? this.isArchive,
       title: title?? this.title,
       uniqueId: uniqueId?? this.uniqueId,
       content: content?? this.content,
       createdTime: createdTime?? this.createdTime
   );
 }





 /////------  convert data from json to Map ------ using Note class structure
 static Note fromJson(Map<String, Object?> json){
   return Note(id: json[NoteImpNames.id] as int?,
       pin: json[NoteImpNames.pin] == 1,
       isArchive: json[NoteImpNames.isArchive] == 1,
       title: json[NoteImpNames.title] as String,
       uniqueId: json[NoteImpNames.uniqueId] as String? ?? "",
       content: json[NoteImpNames.content] as String,
       createdTime: DateTime.parse(json[NoteImpNames.createdTime] as String)
   );
 }


 /////----   convert data from Map to json ------  using NoteImpNames  ----
 Map<String, Object?> toJson(){
   return{
     NoteImpNames.id : id,
     NoteImpNames.pin : pin? 1 : 0,
     NoteImpNames.isArchive : isArchive? 1 : 0,
     NoteImpNames.title : title,
     NoteImpNames.uniqueId : uniqueId,
     NoteImpNames.content : content,
     NoteImpNames.createdTime : createdTime.toIso8601String()
 };
}



}





