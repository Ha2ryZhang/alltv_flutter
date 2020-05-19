import 'package:alltv/pages/live_room_list.dart';
import 'package:flutter/material.dart';

class ChanelDetail extends StatefulWidget {
  //平台类型
  final String com;
  const ChanelDetail({Key key, this.com}) : super(key: key);
  @override
  _ChanelDetailState createState() => _ChanelDetailState();
}

class _ChanelDetailState extends State<ChanelDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buildTitle(widget.com)),
      ),
      body: LiveList(cid: "0", com: widget.com),
    );
  }

  String buildTitle(String com) {
    switch (com) {
      case "douyu":
        return "斗鱼直播";
      case "huya":
        return "虎牙直播";
      case "bilibili":
        return "哔哩哔哩";
      default:
        return "";
    }
  }
}
