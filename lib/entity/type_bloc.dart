import 'dart:async';
import 'package:flutter/material.dart';

import 'models.dart';
import 'db_probider.dart';
class DTypeBloc{
  final _typeController = StreamController<List<DType>>();
  Stream<List<DType>> get typeStream => _typeController.stream;


  getTypes() async{
    _typeController.sink.add(await DBProvider.db.getAllTypes());
  }

  DTypeBloc() {
    getTypes();
  }

  dispose(){
    _typeController.close();
  }

  create(DType type){

    DBProvider.db.createType(type);
    debugPrint("aaa");
    getTypes();

  }

  update(DType type){
    DBProvider.db.updateType(type);
    getTypes();
  }

  delete(int id){
    DBProvider.db.deleteType(id);
    getTypes();
  }

}