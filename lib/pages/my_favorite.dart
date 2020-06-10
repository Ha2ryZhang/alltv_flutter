import 'dart:convert';

import 'package:alltv/http/api.dart';
import 'package:alltv/model/live_room.dart';
import 'package:alltv/route/navigator_util.dart';
import 'package:alltv/utils/utils.dart';
import 'package:alltv/values/storages.dart';
import 'package:alltv/widgets/search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyFavorite extends StatefulWidget {
  @override
  _MyFavoriteState createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  List<LiveRoom> online = [];
  List<LiveRoom> offOnline = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("我的关注", style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "搜索",
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
              // NavigatorUtil.jump(context, Routes.search);
            },
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView(
          children: <Widget>[buildOnlineLiveRoom(), buildOffOnline()],
        ),
      ),
    );
  }

  @override
  void initState() {
    // Map<String, dynamic> favorite =
    //     json.decode(StorageUtil().getJSON(FAVORITE_ROOM));
    // favorite.forEach((key, value) {
    //   online.add(LiveRoom.fromJson(value));
    // });
    super.initState();
  }

  /// 下拉刷新
  void _onRefresh() async {
    try {
      Map<String, dynamic> favorite =
          json.decode(StorageUtil().getJSON(FAVORITE_ROOM));
      setState(() {
        online = [];
        offOnline = [];
      });
      favorite.forEach((key, value) async {
        bool isLive = await API.checkLiveStatus(value["com"], key);
        if (isLive) {
          setState(() {
            online.add(LiveRoom.fromJson(value));
          });
        } else {
          setState(() {
            offOnline.add(LiveRoom.fromJson(value));
          });
        }
      });
    } catch (e) {
      print(e);
      _refreshController.refreshFailed();
    }
    _refreshController.refreshCompleted();
  }

  buildOnlineLiveRoom() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xE6E6E6ff), width: 0.5)),
      child: ExpansionTile(
          title: Text("正在直播", style: TextStyle(fontSize: 12.0)),
          initiallyExpanded: true,
          children: getOnline()),
    );
  }

  List<Widget> getOnline() {
    if (online.length == 0) {
      List<Widget> list = [];
      list.add(Text(
        "暂时还没有关注的主播开播哦。",
        style: TextStyle(color: Colors.grey),
      ));
      return list;
    }
    return online.map((room) {
      return ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: room.avatar,
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            )),
        title: Text(room.ownerName),
        subtitle: Text(room.roomName),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          NavigatorUtil.goLiveoRoom(
              context,
              room.roomId,
              room.com,
              room.roomThumb,
              room.avatar,
              room.roomName,
              room.ownerName,
              room.cateName);
        },
      );
    }).toList();
  }

  List<Widget> getOffOnline() {
    return offOnline.map((room) {
      return ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: room.avatar,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              )),
          title: Text(room.ownerName));
    }).toList();
  }

  buildOffOnline() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xE6E6E6ff), width: 0.5)),
      child: ExpansionTile(
          title: Text("离线中", style: TextStyle(fontSize: 12.0)),
          initiallyExpanded: offOnline.length == 0 ? false : true,
          children: getOffOnline()),
    );
  }
}
