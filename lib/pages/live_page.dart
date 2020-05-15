import 'package:alltv/widgets/alltv_panel.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import '../http/api.dart';

// import 'custom_ui.dart';

class LivePage extends StatefulWidget {
  final String roomId;
  final String com;
  final String url;

  LivePage({@required this.roomId, this.com, this.url});

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final FijkPlayer player = FijkPlayer();
  String url;
  _LivePageState();

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    initRoom();
  }

  void initRoom() {
    API.getLiveUrl(widget.roomId, widget.com).then((value) {
      setState(() {
        url = value;
      });
      startPlay();
    });
  }

  void startPlay() async {
    // await player.setOption(FijkOption.formatCategory, "headers", "User-Agent:Mozilla/5.0 (Linux; Android 9; ONEPLUS A5010 Build/PKQ1.180716.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.149 Mobile Safari/537.36\r\nConnection: keep-alive");
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player
        .setDataSource(widget.url == null ? url : widget.url,
            autoPlay: true, showCover: true)
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
      body: Container(
          //状态栏颜色
          color: Colors.black54,
          child: SafeArea(
            child: Row(
              children: <Widget>[buildPlayer()],
            ),
          )),
    );
  }

  Widget buildPlayer() {
    return FijkView(
      width: MediaQuery.of(context).size.width,
      height: 240,
      player: player,
      color: Colors.black,
      fit: FijkFit.fitWidth,
      panelBuilder: allTVPanelBuilder(snapShot: true, doubleTap: false),
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
