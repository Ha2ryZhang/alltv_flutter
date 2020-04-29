import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String title;

  const TestPage({Key key,this.title}) : super(key: key);

 

  @override
  TestPageState  createState() => new TestPageState();
  }
  
  class TestPageState extends State<TestPage>  {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Text(widget.title),);
  }

}