import 'package:flutter/material.dart';

class Year extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("20XX年"), // <- (※2)
      ),
      body: Center(child: Text("年のページだよ") // <- (※3)
      ),
    );
  }
}