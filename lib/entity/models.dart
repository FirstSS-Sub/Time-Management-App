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
  //指定区間の共通部分があるかないか
  bool hasCommon(DateTime rstart,DateTime rend){
    if(start.compareTo(rend)==1) return false;
    if(end.compareTo(rstart)==-1)return false;
  }
  //指定区間との共通部分を返す
  Duration commonRange(DateTime rstart,DateTime rend){
    if(hasCommon(rstart, rend)){
      DateTime st,ed;
      st = start.compareTo(rstart) < 0 ? rstart : start;
      ed = end.compareTo(rend) > 0 ? rend : end;
      return st.difference(ed);
    }else{
      return new Duration(seconds:0);

    }

  }



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

  bool isnameConflict(DType another){
    return  name == another.name;
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