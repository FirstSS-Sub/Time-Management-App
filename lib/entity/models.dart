import 'package:flutter/cupertino.dart';

class Did{
  int id;
  int type;
  DateTime start;
  DateTime end;

  Did({this.id,@required this.type,@required this.end,@required this.start});
  Did.newTodo(){
    type = null;
    start = DateTime.now();
  }

  factory Did.fromMap(Map<String,dynamic> json) => Did(
    id: json["id"],
    type: json["type"],
    start: DateTime.parse(json["start"]).toLocal(),
    end: DateTime.parse(json["end"]).toLocal()
  );

  Map<String,dynamic> toMap() =>{
    "id": id,
    "type": type,
    "start" : start.toUtc().toIso8601String(),
    "end" : end.toUtc().toIso8601String()
  };

    Map<String,dynamic> toMapWithoutId() =>{
    "type": type,
    "start" : start.toUtc().toIso8601String(),
    "end" : end.toUtc().toIso8601String()
  };

}


class Type{
  int id;
  String name;

  Type({this.id,@required this.name});

  Type.newType(){
    name="";
  }

  factory Type.fromMap(Map<String,dynamic> json) => Type(
    id: json["id"],
    name: json["name"]
  );

  Map<String,dynamic> toMap() => {
    "id":id,
    "name":name
  };
  Map<String,dynamic> toMapWithoutId() => {
     "name":name
  };
}