import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id="home_page";
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Center(
        child:FlatButton(
          onPressed: (){

          },
          color: Colors.blue,
          child: Text("Longout",style: TextStyle(color: Colors.white)
            ,),
        ) ,),
    );
  }
}
