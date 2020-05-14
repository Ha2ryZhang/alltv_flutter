import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("我的关注",style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
      ),
      body: SecondBody(),
    );
  }
}
class SecondBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[ 
        Online(),
        Offline()
      ]
    );
  }
}
class Online extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xE6E6E6ff),width: 0.5)
      ),
      child: ExpansionTile(
        title: Text("正在直播",style: TextStyle(fontSize:12.0)),
        children: <Widget>[
          ListTile(
            leading: Image.network("https://rpic.douyucdn.cn/live-cover/appCovers/2020/02/14/7255932_20200214010515.jpg/webpdy1"),
            title: Text("斗鱼·爱约一只如初见"),
            subtitle: Text("【交友】招收交友主持/颜值第一")
          ),
           ListTile(
            leading: Image.network("https://rpic.douyucdn.cn/live-cover/appCovers/2020/05/11/8720346_20200511102907_small.jpg/webpdy1"),
            title: Text("斗鱼·一只爱笑的鸭梨"),
            subtitle: Text("一只爱笑的鸭梨的直播间")
          ),
           ListTile(
            leading: Image.network("https://rpic.douyucdn.cn/asrpic/200513/5910850_1153.jpg/webpdy1"),
            title: Text("斗鱼·温柚"),
            subtitle: Text("柚柚王者单排教学！")
          ),
           ListTile(
            leading: Image.network("https://rpic.douyucdn.cn/asrpic/200513/5878647_1153.jpg/webpdy1"),
            title: Text("斗鱼·追梦丶清风"),
            subtitle: Text("【战神局】摇摇车！突突你脸上！")
          ),
        ],
        ),
    );
  }
}
class Offline extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xE6E6E6ff),width: 0.5)
      ),
      child: ExpansionTile(
        title: Text("离线中",style: TextStyle(fontSize:12.0)),
        children: <Widget>[
          ListTile(
            title: Text("data1"),
          ),
           ListTile(
            title: Text("data2"),
          ),
           ListTile(
            title: Text("data3"),
          )
        ],
        ),
    );
  }
}