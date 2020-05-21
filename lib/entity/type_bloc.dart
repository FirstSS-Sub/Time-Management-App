import 'dart:async';
import 'package:flutter/material.dart';

import 'models.dart';
import 'db_probider.dart';
class TypeBloc{
  final _typeController = StreamController<List<Type>>();
  Stream<List<Type>> get typeStream => _typeController.stream;


  getTypes() async{
    _typeController.sink.add(await DBProvider.db.getAllTypes());
  }

  TypeBloc() {
    getTypes();
  }

  dispose(){
    _typeController.close();
  }

  create(Type type){

    DBProvider.db.createType(type);
    debugPrint("aaa");
    getTypes();

  }

  update(Type type){
    DBProvider.db.updateType(type);
    getTypes();
  }

  delete(int id){
    DBProvider.db.deleteType(id);
    getTypes();
  }

}