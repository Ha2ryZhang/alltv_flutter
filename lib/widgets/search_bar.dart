import 'package:alltv/http/api.dart';
import 'package:alltv/model/live_room.dart';
import 'package:alltv/pages/loading.dart';
import 'package:alltv/route/navigator_util.dart';
import 'package:alltv/utils/common_convert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomSearchDelegate extends SearchDelegate {
  //默认整合多平台搜索
  String com = "douyu";
  Future future;
  @override
  String get searchFieldLabel => '搜索全网主播、房间号';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future<List<LiveRoom>> fetchData() async {
    return await API.search(com, query);
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == "") {
      return ListView();
    }
    return StatefulBuilder(
      builder: (context, setState) {
        return ListView(children: <Widget>[
          Center(
              child: DropdownButton<String>(
            value: com,
            onChanged: (String newValue) {
              setState(() {
                this.com = newValue;
                this.future = fetchData();
              });
            },
            items: <Com>[
              Com(name: "全部平台", val: "all"),
              Com(name: "斗鱼直播", val: "douyu"),
              Com(name: "虎牙直播", val: "huya")
            ].map<DropdownMenuItem<String>>((Com com) {
              return DropdownMenuItem<String>(
                value: com.val,
                child: Text(com.name),
              );
            }).toList(),
          )),
          FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
                    return buildCard(data[index], context);
                  },
                );
              }
              return Center(child: Lottie.asset("assets/lottie/searching.json"));
            },
          )
        ]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("暂时只支持斗鱼和虎牙的搜索"),
    );
  }

  Widget buildCard(LiveRoom room, BuildContext context) {
    var stack = new Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CachedNetworkImage(
          color: room.roomStatus != 1 ? Colors.grey : null,
          colorBlendMode: BlendMode.color,
          imageUrl: room.roomThumb,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => Image.asset(
            "assets/cache.png",
            fit: BoxFit.fitWidth,
          ),
          errorWidget: (context, url, error) => Image.asset(
            "assets/cache.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        room.roomStatus == 1
            ? Positioned(
                top: 0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 2, right: 2, top: 1, bottom: 1),
                  decoration: new BoxDecoration(color: Colors.grey[850]),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.brightness_1,
                      color: Colors.redAccent,
                      size: 10,
                    ),
                    Text(
                      "直播中",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ]),
                ))
            : Container(),
        Container(
            height: 40,
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
                  convertOnline(room.online),
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
                  context,
                  room.roomId,
                  room.com,
                  room.roomThumb,
                  room.avatar,
                  room.roomName,
                  room.ownerName,
                  room.cateName);
            },
            child: Column(
              children: <Widget>[
                stack,
                Padding(
                    padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                    child: Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            color: room.roomStatus != 1 ? Colors.grey : null,
                            colorBlendMode: BlendMode.color,
                            imageUrl: room.avatar,
                            fit: BoxFit.fill,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            convertCom(room.com) + '·' + room.ownerName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            room.roomName,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ))
                    ])),
              ],
            )));
  }
}

//平台
class Com {
  String name;
  String val;
  Com({
    this.name,
    this.val,
  });
}
