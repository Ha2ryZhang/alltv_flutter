import 'package:alltv/model/live_room.dart';
import 'package:alltv/utils/common_convert.dart';
import 'package:alltv/utils/fluro_convert_util.dart';
import 'package:alltv/utils/toast.dart';
import 'package:alltv/widgets/alltv_panel.dart';
import 'package:alltv/widgets/bilibili_danmaku.dart';
import 'package:alltv/widgets/douyu_danmaku.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import '../http/api.dart';

// import 'custom_ui.dart';

class LivePage extends StatefulWidget {
  final LiveRoom room;

  LivePage({@required this.room});

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final FijkPlayer player = FijkPlayer();
  String url;
  String roomThumb;
  String avatar;
  String roomName;
  String ownerName;
  String cateName;
  _LivePageState();
  //是否关注
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    //对路由中文参数进行decode
    roomThumb = FluroConvertUtils.fluroCnParamsDecode(widget.room.roomThumb);
    avatar = FluroConvertUtils.fluroCnParamsDecode(widget.room.avatar);
    roomName = FluroConvertUtils.fluroCnParamsDecode(widget.room.roomName);
    ownerName = FluroConvertUtils.fluroCnParamsDecode(widget.room.ownerName);
    roomName = FluroConvertUtils.fluroCnParamsDecode(widget.room.roomName);
    ownerName = FluroConvertUtils.fluroCnParamsDecode(widget.room.ownerName);
    cateName = FluroConvertUtils.fluroCnParamsDecode(widget.room.cateName);

    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    initRoom();
  }

  void initRoom() {
    API.getLiveUrl(widget.room.roomId, widget.room.com).then((value) {
      setState(() {
        url = value;
      });
      // startPlay();
    });
  }

  void startPlay() async {
    // await player.setOption(FijkOption.formatCategory, "headers",
    //     "User-Agent : Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.11 TaoBrowser/2.0 Safari/536.11\r\nexe:123");
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player
        .setDataSource(url, autoPlay: true, showCover: true)
        .catchError((e) {
      print("setDataSource error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          // buildPlayer(),
          buildRoomInfo(),
          Expanded(child: buildDanmakuList(widget.room.com)),
        ],
      ),
    );
  }

  Widget buildDanmakuList(String com) {
    switch (com) {
      case "bilibili":
        return LiveDanmakuPage(int.parse(widget.room.roomId));
      case "douyu":
        return DouYuLiveDanmakuPage(int.parse(widget.room.roomId));
      default:
        return Center(
          child: Text("目前仅支持B站弹幕,后续会整合其他平台的。"),
        );
    }
  }

  Widget buildRoomInfo() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400], width: 1),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: "$avatar",
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              )),
          title: Text(convertCom(widget.room.com) + "·$ownerName"),
          subtitle: Text("$roomName"),
          trailing: IconButton(
              icon: Icon(
                Icons.favorite,
                color: isFavorite ? Colors.pink : Colors.grey[400],
              ),
              onPressed: favoriteOrCancel),
        ));
  }

  void favoriteOrCancel() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ///TODO 添加到本地储存 后期云同步
    if (isFavorite) {
      showToast("关注成功");
    }
  }

  Widget buildPlayer() {
    var width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.black54,
        child: SafeArea(
          child: FijkView(
            width: width,
            height: 240,
            player: player,
            cover: Image.network(
              roomThumb,
            ).image,
            color: Colors.black,
            fit: FijkFit.fitWidth,
            panelBuilder: allTVPanelBuilder(snapShot: true, doubleTap: false),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
