import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: Text("我",style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
      ),
      body: ThirdBody(),
    );
  }
}

class ThirdBody extends StatelessWidget{
    @override 
  Widget build(BuildContext context) {
    return  ListView(
      children: <Widget>[
        ThirdUp(),
        MessageCenter(),
        History(),
        LabelMan(),
        NightMode(),
        Feedback(),
        Setting()
      ]
            
    );
  }
}

/// Third Up
class ThirdUp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.5)
          ),
          child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage("https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3744215463,383557679&fm=26&gp=0.jpg"),
            radius: 25.0,
          ),
          title: Text("data1",style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Row(
            children: <Widget>[
              Text("data2")
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        );
  }
}
/// MessageCenter 消息中心
class MessageCenter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.textsms,),
        title: Text("消息中心",style: TextStyle(fontSize: 16.0),),
      )
    );
  }
}
/// History 历史记录
class History extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.visibility,),
        title: Text("历史记录",style: TextStyle(fontSize: 16.0),),
        trailing: Text("data1",style: TextStyle(color: Colors.grey)),
      )
    );
  }
}
/// LabelMan 标签管理
class LabelMan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 10),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.turned_in,),
        title: Text("标签管理",style: TextStyle(fontSize: 16.0),),
        trailing: Text("data1",style: TextStyle(color: Colors.grey)),
      )
    );
  }
}
/// NightMode 夜间模式
class NightMode extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    bool check = false;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.brightness_medium,),
        title: Text("夜间模式",style: TextStyle(fontSize: 16.0),),
        trailing: Switch(
              value: check, 
              onChanged: (bool check) {
                check = !check;
              },
              activeColor: Colors.blue,
              ),
      )
    );
  }
}
/// Feedback 意见反馈
class Feedback extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.assignment_late,),
        title: Text("意见反馈",style: TextStyle(fontSize: 16.0),),
      )
    );
  }
}
/// Setting 设置
class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xE6E6E6ff),width: 0.3)
          ),
      child: ListTile(
        leading: Icon(Icons.settings,),
        title: Text("设置",style: TextStyle(fontSize: 16.0),),
      )
    );
  }
}