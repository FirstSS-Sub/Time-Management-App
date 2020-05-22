import 'dart:async';
import 'models.dart';
import 'db_provider.dart';
class DidBloc{
  final _didController = StreamController<List<Did>>();
  Stream<List<Did>> get didStream => _didController.stream;


  getDids() async{
    _didController.sink.add(await DBProvider.db.getAllDid());
  }

  DidBloc() {
    getDids();
  }

  dispose(){
    _didController.close();
  }

  create(Did did){

    DBProvider.db.createDid(did);
    getDids();

  }

  update(Did did){
    DBProvider.db.updateDid(did);
    getDids();
  }

  delete(int id){
    DBProvider.db.deleteDid(id);
    getDids();
  }

}