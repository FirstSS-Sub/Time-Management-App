import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:time_management_app/entity/db_probider.dart';
import 'package:time_management_app/entity/models.dart';


void main() {
    WidgetsFlutterBinding.ensureInitialized();

  var db = DBProvider.db;


  group("A test", (){
    test("datacount == 0",() async {
      
    expect((await db.getAllTypes()).length, 0);      
    });

    test("after append",() async{
      DType t = new DType(name: "test", red: 1, green: 1, blue: 1);
      db.createType(t);
      expect((await db.getAllTypes()).length, 1);      




    });
  });


}