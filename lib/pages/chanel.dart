import 'package:alltv/route/navigator_util.dart';
import 'package:flutter/material.dart';

class ChanelPage extends StatefulWidget {
  @override
  _ChanelPageState createState() => _ChanelPageState();
}

class _ChanelPageState extends State<ChanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("所有平台", style: TextStyle(fontSize: 16.0)),
          centerTitle: true,
        ),
        body: buildChanelList());
  }

  Widget buildChanelList() {
    return ListView(padding: const EdgeInsets.only(top: 10), children: <Widget>[
      // Row(
      //   children: <Widget>[
      //     ClipRRect(
      //         borderRadius: BorderRadius.circular(8),
      //         child: Image.asset("assets/images/douyu.jpg",
      //             fit: BoxFit.fill, width: 80, height: 80)),
      //     Text("sddas")
      //   ],

      // )
      ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/images/douyu.jpg",
                fit: BoxFit.fill, width: 55, height: 55)),
        title: Text("斗鱼直播"),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          NavigatorUtil.goChanelDetail(context, "douyu");
        },
      ),
      Divider(
        height: 1.0,
        indent: 0.0,
        color: Colors.grey[400],
      ),
      ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/images/huya.jpg",
                fit: BoxFit.fill, width: 55, height: 55)),
        title: Text("虎牙直播"),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          NavigatorUtil.goChanelDetail(context, "huya");
        },
      ),
      Divider(
        height: 1.0,
        indent: 0.0,
        color: Colors.grey[400],
      ),
      ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/images/bilibili.jpg",
                fit: BoxFit.fill, width: 55, height: 55)),
        title: Text("哔哩哔哩"),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          NavigatorUtil.goChanelDetail(context, "bilibili");
        },
      ),
      Divider(
        height: 1.0,
        indent: 0.0,
        color: Colors.grey[400],
      ),
      Container(
        margin: const EdgeInsets.only(top: 200),
        child: Center(
          child: Text(
            "后续会整合其他平台...",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      )
    ]);
  }
}
