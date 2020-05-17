import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索",style:TextStyle(fontSize:16.0)),
        centerTitle: true,
      ),
      body: SearchBody(),
    );
  }
}
class SearchBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("开发正在日夜不眠的码功能！"),),
    );
  }
}