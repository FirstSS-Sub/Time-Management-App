import 'package:flutter/material.dart';

import 'routes/home/home_provider.dart';
import 'routes/day.dart';
import 'routes/month.dart';
import 'routes/year.dart';

class RootWidget extends StatefulWidget{
  RootWidget({Key key}) : super(key: key);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget>{
  int _selectedIndex = 0; // 最初はホーム
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // アイコン情報
  static const _footerIcons = [
    Icons.home,
    Icons.access_alarm,
    Icons.access_time,
    Icons.content_paste,
  ];

  // アイコン文字列
  static const _footerItemNames = [
    'ホーム',
    '日',
    '月',
    '年',
  ];

  var _routes = [
    Home(),
    Day(),
    Month(),
    Year(),
  ];

  @override
  void initState() {
    super.initState(); // 継承元のState<Footer>のinitStateを実行
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for ( var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }

  /// インデックスのアイテムをアクティベートする
  /// black87は結構濃い
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        )
    );
  }

  /// インデックスのアイテムをディアクティベートする
  /// black26はうすい灰色っぽい
  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        )
    );
  }

  /// タップされたとき
  void _onItemTapped(int index) {
    setState(() {
      // 元々選択されていたアイコンを灰色にディアクティベート
      _bottomNavigationBarItems[_selectedIndex] = _UpdateDeactiveState(_selectedIndex);

      // 選択したアイコンを黒にアクティベート
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);

      // 選択した今のアイコンをselectedIndexに
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 引数によって違う画面を表示
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}