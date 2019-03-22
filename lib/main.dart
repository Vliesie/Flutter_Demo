import 'package:flutter/material.dart';
import 'package:test2/Login_Page.dart';
import 'Auth.dart';
import 'root_page.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
        title: 'Technical Assesment',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth())
    );
  }
}