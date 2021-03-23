import 'dart:async';
import 'dart:convert';

import 'package:alltv/model/live_room.dart';
import 'package:alltv/pages/loading.dart';
import 'package:alltv/utils/common_convert.dart';
import 'package:alltv/utils/fluro_convert_util.dart';
import 'package:alltv/utils/toast.dart';
import 'package:alltv/utils/utils.dart';
import 'package:alltv/values/storages.dart';
import 'package:alltv/widgets/bilibili_danmaku.dart';
import 'package:alltv/widgets/douyu_danmaku.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:wakelock/wakelock.dart';

import '../http/api.dart';

class LivePage extends StatefulWidget {
  final LiveRoom room;

  LivePage({required this.room});

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  // final FijkPlayer player = FijkPlayer();
  String? url;
  String? roomThumb;
  String? avatar;
  String? roomName;
  String? ownerName;
  String? cateName;
  _LivePageState();
  //是否关注
  bool isFavorite = false;
  final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.primary,
    pipEnabled: true,
    showPipButton: true,
  );
  StreamSubscription? _playerEventSubs;
  @override
  void initState() {
    super.initState();
    //对路由中文参数进行decode
    roomThumb = FluroConvertUtils.fluroCnParamsDecode(widget.room.roomThumb!);
    widget.room.roomThumb = roomThumb;
    avatar = FluroConvertUtils.fluroCnParamsDecode(widget.room.avatar!);
    widget.room.avatar = avatar;
    roomName = FluroConvertUtils.fluroCnParamsDecode(widget.room.roomName!);
    widget.room.roomName = roomName;
    ownerName = FluroConvertUtils.fluroCnParamsDecode(widget.room.ownerName!);
    widget.room.ownerName = ownerName;
    cateName = FluroConvertUtils.fluroCnParamsDecode(widget.room.cateName!);
    widget.room.cateName = cateName;

    _playerEventSubs = _meeduPlayerController.onPlayerStatusChanged.listen(
      (PlayerStatus status) {
        if (status == PlayerStatus.playing) {
          Wakelock.enable();
        } else {
          Wakelock.disable();
        }
      },
    );

    //判断是否关注房间
    var favoriteJson = StorageUtil().getJSON(FAVORITE_ROOM);
    if (favoriteJson != null) {
      Map<String, dynamic> favorite = json.decode(favoriteJson);
      favorite.forEach((key, value) {
        if (key == widget.room.roomId) {
          setState(() {
            isFavorite = true;
          });
        }
      });
    }
    initRoom();
  }

  void initRoom() {
    API.getLiveUrl(widget.room.roomId, widget.room.com).then((value) {
      setState(() {
        url = value;
      });
      _meeduPlayerController.setDataSource(
        DataSource(
          type: DataSourceType.network,
          source: this.url,
        ),
        autoplay: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return LoadingPage();
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          buildPlayer(),
          buildRoomInfo(),
          Expanded(child: buildDanmakuList(widget.room.com)),
        ],
      ),
    );
  }

  Widget buildDanmakuList(String? com) {
    switch (com) {
      case "bilibili":
        return LiveDanmakuPage(int.parse(widget.room.roomId!));
      case "douyu":
        return DouYuLiveDanmakuPage(int.parse(widget.room.roomId!));
      default:
        return Center(
          child: Text("目前仅支持B站和斗鱼弹幕,后续会整合其他平台的。"),
        );
    }
  }

  Widget buildRoomInfo() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]!, width: 1),
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
    //读取关注列表
    var favoriteJson = StorageUtil().getJSON(FAVORITE_ROOM);
    Map<String?, dynamic>? favorite;

    if (isFavorite) {
      if (favoriteJson != null) {
        favorite = json.decode(favoriteJson);
      } else {
        favorite = Map<String?, dynamic>();
      }
      favorite![widget.room.roomId]=widget.room;
      showToast("关注成功");
    } else {
      favorite = json.decode(favoriteJson);
      favorite!.remove(widget.room.roomId);
    }
    StorageUtil().setJSON(FAVORITE_ROOM, json.encode(favorite));
  }

  Widget buildPlayer() {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: MeeduVideoPlayer(
          controller: _meeduPlayerController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _playerEventSubs?.cancel();
    Wakelock.disable();
    _meeduPlayerController.dispose();
    super.dispose();
  }
}
