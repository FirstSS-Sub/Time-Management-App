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


class DType{
  int id;
  int red;
  int green;
  int blue;
  String name;

  DType({this.id,@required this.name,@required this.red,@required this.green,@required blue});

  DType.newType(){
    name="";
    red=0;
    green=0;
    blue=0;
  }

  bool isSameColor(DType another){
    return red==another.red && green==another.green && blue == another.blue;
  }

  factory DType.fromMap(Map<String,dynamic> json) => DType(
    id: json["id"],
    name: json["name"],
    red: json["red"],
    green: json["green"],
    blue: json["blue"]

  );

  Map<String,dynamic> toMap() => {
    "id":id,
    "name":name,
    "red":red,
    "green":green,
    "blue":blue
  };
  Map<String,dynamic> toMapWithoutId() => {
    "name":name,
    "red":red,
    "green":green,
    "blue":blue
  };
}