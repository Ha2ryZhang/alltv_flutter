import 'package:alltv/config/global.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((e) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryList>.value(
            value: Global.categories,
          ),
        ],
        child: new MyApp()
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      title: 'All TV',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}

//chewie 这个方案一般，不太习惯
// import 'package:alltv/widgets/playerUi.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// void main() {
//   runApp(
//     ChewieDemo(),
//   );
// }

// class ChewieDemo extends StatefulWidget {
//   ChewieDemo({this.title = 'Chewie Demo'});

//   final String title;

//   @override
//   State<StatefulWidget> createState() {
//     return _ChewieDemoState();
//   }
// }

// class _ChewieDemoState extends State<ChewieDemo> {
//   TargetPlatform _platform;
//   VideoPlayerController _videoPlayerController1;
//   ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController1 = VideoPlayerController.network(
//         'https://cn-hbxy-cmcc-live-01.live-play.acgvideo.com/live-bvc/live_510967875_16148656.m3u8');
//     _chewieController = new ChewieController(
//         videoPlayerController: _videoPlayerController1,
//         aspectRatio: 16 / 9,
//         autoPlay: true,
//         looping: false,
//         isLive: true,
//         customControls: MyChewieMaterialControls(refresh)

//         // showControls: false,
//         // materialProgressColors: ChewieProgressColors(
//         //   playedColor: Colors.red,
//         //   handleColor: Colors.blue,
//         //   backgroundColor: Colors.grey,
//         //   bufferedColor: Colors.lightGreen,
//         // ),
//         // placeholder: Container(
//         //   color: Colors.grey,
//         // ),
//         // autoInitialize: true,
//         );
//   }

//   void refresh() {
//     setState(() {
//       if (_chewieController != null) {
//         _chewieController.dispose();
//       }
//       if (_videoPlayerController1 != null) {
//         _videoPlayerController1.dispose();
//       }
//       _videoPlayerController1 = new VideoPlayerController.network(
//           "http://tx2play1.douyucdn.cn/live/1863767rkpl.flv");
//       _chewieController = ChewieController(
//           videoPlayerController: _videoPlayerController1,
//           aspectRatio: 16 / 9,
//           autoPlay: true,
//           isLive: true,
//           looping: false,
//           customControls: MyChewieMaterialControls(refresh));
//     });
//   }

//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: widget.title,
//       theme: ThemeData.light().copyWith(
//         platform: _platform ?? Theme.of(context).platform,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Column(children: <Widget>[
//           Center(
//             child: Chewie(
//               controller: _chewieController,
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

// fijkplayer 但是我不喜欢这个鸡儿作者，高傲，估计还copy了 flutter_ijkplayer 的代码

// import 'package:alltv/widgets/video.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           // Here we take the value from the MyHomePage object that was created by
//           // the App.build method, and use it to set our appbar title.
//           title: Text("widget.title"),
//         ),
//         body: Center(
//           // Center is a layout widget. It takes a single child and positions it
//           // in the middle of the parent.
//           child: VideoScreen(
//               url:
//                  "http://tx2play1.douyucdn.cn/live/4446841rfs5cPn2r.flv"),
//         ),
//       ),
//     );
//   }
// }
