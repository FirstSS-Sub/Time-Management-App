import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_app/root.dart';
import 'package:time_management_app/entity/models.dart';
import 'package:time_management_app/entity/type_bloc.dart';

import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class RegisterView extends StatelessWidget {
  var _nameController = TextEditingController(); //TextFieldの中身を色々操作するためのコントローラ

  var taskRed = -1;
  var taskGreen = -1;
  var taskBlue = -1;

  var _sameNameFlag = 0;
  var _sameColorFlag = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DTypeBloc>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text("作業登録"), // <- (※2)
        ),
        body:
        StreamBuilder<List<DType>>(
          stream: _bloc.typeStream,
          builder: (BuildContext context, AsyncSnapshot<List<DType>> snapshot) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // containerだらけになると汚いので、別途Widgetで記述
                  _textArea(_nameController),
                  _colorArea(),
                  RaisedButton(
                    elevation: 4.0, // 影の深さ
                    child: Text("登録する"),
                    onPressed: () {
                      // データベースに登録するか判断する処理
                      DTypeBloc taskBloc = new DTypeBloc();
                      DType task = new DType.newType();
                      task.name = _nameController.text;
                      task.red = taskRed;
                      task.green = taskGreen;
                      task.blue = taskBlue;
                      for (final data in snapshot.data) {
                        if (task.isSameName(data)) {
                          print("name conflict");
                          _sameNameFlag = 1;
                          break;
                        }
                        _sameNameFlag = 0;
                        if (task.isSameColor(data)) {
                          print("color conflict");
                          _sameColorFlag = 1;
                          break;
                        }
                        _sameColorFlag = 0;
                      }

                      if (this._formKey.currentState.validate()) {
                        this._formKey.currentState.save();
                        // データベースに登録
                        print("${task.red}");
                        taskBloc.create(task);

                        // 元の画面に戻る処理
                        //Navigator.of(context).pop(); // これだと戻るボタンを押していることになってしまう
                        //Navigator.of(context).pushReplacementNamed("/"); // これだと直前のものしか消えない
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => RootWidget()
                          ),
                              (_) => false, // どこまで遡って削除するかの条件 falseだと全削除
                        );
                      }
                    },
                    color: Colors.orange,
                  ),
                ],
              )
            );
          }
        ),
    );
  }

  Widget _textArea(_nameController) {
    return Container(
      height: 70.0,
      width: double.infinity,
      // 開発時に見やすくするために色付けしとく
      // color: Colors.red,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(18.0),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
            hintText: '作業名を入力してください'
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "作業名が入力されていません";
          }
          else if (taskRed == -1) {
            return "色のバーを少し動かして選択してください";
          }
          else if (_sameNameFlag == 1) {
            return "既に存在する作業名です";
          }
          else if (_sameColorFlag == 1) {
            return "既に存在する色です";
          }
          else{
            return null;
          }
        },
      ),
    );
  }

  Widget _colorArea() {
    return Container(
      height: 270.0,
      child: Center(
        child: CircleColorPicker(
          initialColor: Colors.blue,
          onChanged: (color) => {
            taskRed = color.red,
            taskGreen = color.green,
            taskBlue = color.blue
          },
          size: const Size(240, 240),
          strokeWidth: 4,
          thumbSize: 36,
        ),
      ),
    );
  }
}