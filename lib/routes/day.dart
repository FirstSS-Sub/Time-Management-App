import 'package:flutter/material.dart';

class Day extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20XX年 YY月 ZZ日"), // <- (※2)
      ),
      body: Center(child: Text("日にちのページだよ") // <- (※3)
      ),
    );
  }
}