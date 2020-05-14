import 'package:flutter/material.dart';
import 'package:time_management_app/register.dart';

class Home extends StatelessWidget { // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム"), // <- (※2)
      ),
      body: Center(child: Text("ホームだよ") // <- (※3)
      ),
      floatingActionButton: FloatingActionButton.extended(
        // tooltip: 'Next',
        // child: Icon(Icons.arrow_right),
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => Register())
        ),
      ),
    );
  }
}