import 'package:alltv/http/api.dart';
import 'package:alltv/model/live_room.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LiveList extends StatefulWidget {
  //分类id
  final String cid;
  const LiveList({Key key, this.cid}) : super(key: key);

  @override
  _LiveListState createState() => _LiveListState();
}

class _LiveListState extends State<LiveList>
    with AutomaticKeepAliveClientMixin {
  List<LiveRoom> _liveRooms;

  @override
  void initState() {
    super.initState();
    loadData(widget.cid);
  }

  loadData(String cid) async {
    var list = await API.getRecommend(cid);
    setState(() {
      _liveRooms = new List();
      _liveRooms = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_liveRooms == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
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

  Future<Null> _onRefresh() async {
    loadData(widget.cid);
    return;
  }

  String convertCom(String com) {
    switch (com) {
      case 'douyu':
        return "斗鱼";
      default:
        return "未知";
    }
  }

  Widget buildCard(LiveRoom room) {
    var stack = new Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: room.roomThumb,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
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
            onTap: () {},
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
