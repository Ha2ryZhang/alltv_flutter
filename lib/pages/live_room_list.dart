import 'package:alltv/http/api.dart';
import 'package:alltv/model/live_room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../route/navigator_util.dart';

class LiveList extends StatefulWidget {
  //分类id
  final String cid;
  const LiveList({Key key, this.cid}) : super(key: key);

  @override
  _LiveListState createState() => _LiveListState();
}

class _LiveListState extends State<LiveList>
    with AutomaticKeepAliveClientMixin {
  List<LiveRoom> _liveRooms = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _pageNum = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 下拉刷新
  void _onRefresh() async {
    var list = await API.getRecommend(widget.cid, 1);
    setState(() {
      _liveRooms = list;
    });
    if (_liveRooms != null) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
  }

  ///上拉加载
  void _onLoading() async {
    var list = await API.getRecommend(widget.cid, _pageNum + 1);
    setState(() {
      _pageNum++;
      _liveRooms.addAll(list);
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: "Loading",
      ),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _liveRooms.length,
          itemBuilder: (context, index) {
            return buildCard(_liveRooms[index]);
          }),
    );
  }

  List<Widget> buildCardList() {
    List<Widget> list = [];
    _liveRooms.forEach((room) {
      list.add(buildCard(room));
    });
    return list;
  }

  String convertCom(String com) {
    switch (com) {
      case 'douyu':
        return "斗鱼";
      case 'bilibili':
        return "B站";
      default:
        return "未知";
    }
  }

  Widget buildCard(LiveRoom room) {
    var width = MediaQuery.of(context).size.width;
    var stack = new Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: room.roomThumb,
          fit: BoxFit.fitWidth,
          width: width,
          placeholder: (context, url) => Image.asset(
            "assets/images/cache.png",
            fit: BoxFit.fitWidth,
            width: width,
          ),
          errorWidget: (context, url, error) => Image.asset(
            "assets/images/cache.png",
            fit: BoxFit.fitWidth,
            width: width,
          ),
        ),
        new Container(
            width: 400,
            height: 50,
            padding: const EdgeInsets.all(5),
            alignment: Alignment.bottomLeft,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12,
                  Colors.black54,
                ],
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: new Text(
                      room.cateName,
                      style: new TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )),
                new Icon(
                  Icons.whatshot,
                  color: Colors.white70,
                  size: 20,
                ),
                new Text(
                  room.online.toString(),
                  style: new TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ],
    );

    return Card(
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              NavigatorUtil.goLiveoRoom(
                  context, room.roomId, room.com, room.realUrl);
            },
            child: Column(
              children: <Widget>[
                stack,
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 5),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(room.avatar,
                          fit: BoxFit.fill, width: 50, height: 50)),
                  title: Text(convertCom(room.com) + '·' + room.ownerName),
                  subtitle: Text(room.roomName),
                ),
              ],
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
