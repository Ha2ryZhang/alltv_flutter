import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class DouYuLiveDanmakuPage extends StatefulWidget {
  final int roomId;
  DouYuLiveDanmakuPage(this.roomId);
  @override
  _LiveDanmakuPageState createState() => _LiveDanmakuPageState();
}

class _LiveDanmakuPageState extends State<DouYuLiveDanmakuPage>
    with AutomaticKeepAliveClientMixin<DouYuLiveDanmakuPage> {
  Timer timer;
  IOWebSocketChannel _channel;
  int totleTime = 0;
  List _messageList = [];
  @override
  void initState() {
    // timer = Timer.periodic(Duration(seconds: 70), (callback) {
    //   totleTime += 70;
    //   //sendXinTiaoBao();
    //   print("时间: $totleTime s");
    //   _channel.sink?.close();
    //   initLive();
    // });
    initLive();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _channel?.sink?.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  //初始化
  void initLive() {
    _channel = IOWebSocketChannel.connect("wss://danmuproxy.douyu.com:8501");
    login();
    setListener();
  }

  void sendXinTiaoBao() {
    List<int> code = [0, 0, 0, 16, 0, 16, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1];
    _channel.sink.add(Uint8List.fromList(code).buffer);
  }

  //加入房间
  void joinRoom(int id) {
    // _channel.sink.add();
  }

  //设置监听
  void setListener() {
    _channel.stream.listen((msg) {
      // Uint8List list = Uint8List.fromList(msg);
      print(msg);
    });
  }

  void login() {
    print("login");
    String roomID = widget.roomId.toString();
    String login = "type@=loginreq/roomid@=$roomID/\x00";
    sendMsg(login);
    String joingroup = "type@=joingroup/rid@=$roomID/gid@=-9999/\x00";
    sendMsg(joingroup);
  }

  //对消息编码
  void sendMsg(String msg) {
    List<int> msgData = utf8.encode(msg);
    List<int> header = [
      0,
      0,
      0,
      msgData.length + 8,
      0,
      0,
      0,
      msgData.length + 8,
      0,
      689
    ];
    List<int> tmp = new List();
    tmp.addAll(header);
    tmp.addAll(msgData);
    _channel.sink.add(Uint8List.fromList(tmp));
  }

  //对消息进行解码
  decode(Uint8List list) {}

  //写入编码
  Uint8List writeInt(Uint8List src, int start, int len, int value) {
    int i = 0;
    while (i < len) {
      src[start + i] = value ~/ pow(256, len - i - 1);
      i++;
    }
    return src;
  }

  //从编码读出数字
  int readInt(Uint8List src, int start, int len) {
    int res = 0;
    for (int i = len - 1; i >= 0; i--) {
      res += pow(256, len - i - 1) * src[start + i];
    }
    return res;
  }

  void addDanmaku(LiveDanmakuItem item) {
    setState(() {
      _messageList.insert(0, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: _messageList.length,
        padding: const EdgeInsets.only(left: 5, top: 2, right: 5),
        reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          Widget item;
          if (_messageList[i] is LiveDanmakuItem) {
            LiveDanmakuItem liveDanmakuItem = _messageList[i];
            item = Container(
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    " ${liveDanmakuItem.name} : ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Text(
                      "${liveDanmakuItem.msg}",
                    ),
                  )
                ],
              ),
            );
          }
          return item;
        });
  }
}

class LiveDanmakuItem {
  String name;
  String msg;
  LiveDanmakuItem(this.name, this.msg);
}
