import 'package:flutter/material.dart';
import 'package:time_management_app/entity/models.dart';
import 'entity/type_bloc.dart';

class Register extends StatelessWidget { // <- (※1)
  var _nameController = TextEditingController(); //TextFieldの中身を色々操作するためのコントローラ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("作業登録"), // <- (※2)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // containerだらけになると汚いので、別途Widgetで記述
          _textArea(_nameController),
          _colorArea(),
          RaisedButton(
            elevation: 4.0, // 影の深さ
            child: Text("登録する"),
            onPressed: () {
              // データベースに登録する処理
              TypeBloc taskBloc = new TypeBloc();
              Type task = new Type.newType();
              task.name = _nameController.text;
              taskBloc.create(task);

              // 元の画面に戻る処理
              Navigator.of(context).pop();
            },
            color: Colors.orange,
          ),
        ],
      )
    );
  }

  Widget _textArea(_nameController) {
    return Container(
      height: 100.0,
      width: double.infinity,
      // 開発時に見やすくするために色付けしとく
      color: Colors.red,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
            hintText: '作業名を入力してください'
        ),
      ),
    );
  }

  Widget _colorArea() {
    return Container(
      height: 250.0,
      width: double.infinity,
      // 開発時に見やすくするために色付けしとく
      color: Colors.limeAccent,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Center(child: Text("ここに色を選ぶボタンたくさん")),
    );
  }
}