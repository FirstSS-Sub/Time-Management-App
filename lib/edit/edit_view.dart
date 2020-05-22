import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_app/entity/models.dart';
import 'package:time_management_app/entity/type_bloc.dart';
import 'package:time_management_app/root.dart';

import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

// ignore: must_be_immutable
class EditView extends StatelessWidget {
  var _nameController;
  var taskRed;
  var taskGreen;
  var taskBlue;

  DType task;
  EditView(this.task) {
    _nameController= new TextEditingController(text: task.name); //TextFieldの中身を色々操作するためのコントローラ
    taskRed = task.red;
    taskGreen = task.green;
    taskBlue = task.blue;
  }

  var _sameNameFlag = 0;
  var _sameColorFlag = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DTypeBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name), // <- (※2)
        backgroundColor: Color.fromARGB(255, task.red, task.green, task.blue)
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
                      child: Text("編集する"),
                      onPressed: () {
                        // データベースに登録するか判断する処理
                        DType newTask = new DType(
                            name: _nameController.text,
                            red: taskRed,
                            green: taskGreen,
                            blue: taskBlue
                        );

                        if (task.name == newTask.name) { // 名前が変わっていなかった場合
                          if (task.red == newTask.red && task.green == newTask.green &&
                              task.blue == newTask.blue) { // 色も変わっていなかった場合
                            // 何もしない。可読性を上げるためにあえて書いておく。
                          }
                          else { // 色だけ変わっていた場合
                            for (final data in snapshot.data) {
                              if (newTask.isSameColor(data)) {
                                print("color conflict");
                                _sameColorFlag = 1;
                                break;
                              }
                              _sameColorFlag = 0;
                            }
                          }
                        }
                        else {
                          if (task.red == newTask.red && task.green == newTask.green &&
                              task.blue == newTask.blue) { // 名前だけ変わっていた場合
                            for (final data in snapshot.data) {
                              if (newTask.isSameName(data)) {
                                print("name conflict");
                                _sameNameFlag = 1;
                                break;
                              }
                              _sameNameFlag = 0;
                            }
                          }
                          else {
                            for (final data in snapshot.data) {
                              if (newTask.isSameName(data)) {
                                print("name conflict");
                                _sameNameFlag = 1;
                                break;
                              }
                              _sameNameFlag = 0;
                              if (newTask.isSameColor(data)) {
                                print("color conflict");
                                _sameColorFlag = 1;
                                break;
                              }
                              _sameColorFlag = 0;
                            }
                          }
                        }

                        if (this._formKey.currentState.validate()) {
                          this._formKey.currentState.save();
                          // データベースに登録
                          newTask.id = task.id;
                          DTypeBloc().update(newTask); // 同じidを持つDTypeを、内容だけアップデートする

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
                      color: Colors.lightBlue,
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
            hintText: '新しい作業名を入力してください'
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "作業名が入力されていません";
          }
          else if (_sameNameFlag == 1) {
            return "既に存在する作業名です";
          }
          else if (_sameColorFlag == 1) {
            return "既に存在する色です";
          }
          else {
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
          initialColor: Color.fromARGB(255, task.red, task.green, task.blue),
          onChanged: (color) =>
          {
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