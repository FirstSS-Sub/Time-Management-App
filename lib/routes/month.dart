import 'package:flutter/material.dart';

class Month extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20XX年 YY月"), // <- (※2)
      ),
      body: Center(child: Text("月のページ") // <- (※3)
      ),
    );
  }
}