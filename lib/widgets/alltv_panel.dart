// import 'dart:async';
// import 'dart:math';

// import 'package:fijkplayer/fijkplayer.dart';
// import 'package:flutter/material.dart';

// FijkPanelWidgetBuilder allTVPanelBuilder(
//     {Key key,
//     final bool fill = false,
//     final int duration = 4000,
//     final bool doubleTap = true,
//     final bool snapShot = false,
//     final String title = '',
//     final VoidCallback onBack}) {
//   return (FijkPlayer player, FijkData data, BuildContext context, Size viewSize,
//       Rect texturePos) {
//     return _FijkPanel2(
//       key: key,
//       player: player,
//       data: data,
//       onBack: onBack,
//       viewSize: viewSize,
//       texPos: texturePos,
//       fill: fill,
//       doubleTap: doubleTap,
//       snapShot: snapShot,
//       title: title,
//       hideDuration: duration,
//     );
//   };
// }

// class _FijkPanel2 extends StatefulWidget {
//   final FijkPlayer player;
//   final FijkData data;
//   final VoidCallback onBack;
//   final Size viewSize;
//   final Rect texPos;
//   final bool fill;
//   final bool doubleTap;
//   final bool snapShot;
//   final String title;
//   final int hideDuration;

//   const _FijkPanel2(
//       {Key key,
//       @required this.player,
//       this.data,
//       this.fill,
//       this.onBack,
//       this.viewSize,
//       this.hideDuration,
//       this.doubleTap,
//       this.snapShot,
//       this.texPos,
//       this.title = 'this is title'})
//       : assert(player != null),
//         assert(
//             hideDuration != null && hideDuration > 0 && hideDuration < 10000),
//         super(key: key);

//   @override
//   __FijkPanel2State createState() => __FijkPanel2State();
// }

// class __FijkPanel2State extends State<_FijkPanel2> {
//   FijkPlayer get player => widget.player;

//   Timer _hideTimer;
//   bool _hideStuff = true;

//   Timer _statelessTimer;
//   bool _prepared = false;
//   bool _playing = false;
//   bool _dragLeft;
//   double _volume;
//   double _brightness;

//   double _seekPos = -1.0;
//   Duration _duration = Duration();
//   Duration _currentPos = Duration();
//   Duration _bufferPos = Duration();

//   StreamSubscription _currentPosSubs;
//   StreamSubscription _bufferPosSubs;

//   StreamController<double> _valController;

//   // snapshot
//   ImageProvider _imageProvider;
//   Timer _snapshotTimer;

//   static const FijkSliderColors sliderColors = FijkSliderColors(
//       cursorColor: Color.fromARGB(240, 250, 100, 10),
//       playedColor: Color.fromARGB(200, 240, 90, 50),
//       baselineColor: Color.fromARGB(100, 20, 20, 20),
//       bufferedColor: Color.fromARGB(180, 200, 200, 200));

//   @override
//   void initState() {
//     super.initState();

//     _valController = StreamController.broadcast();
//     _prepared = player.state.index >= FijkState.prepared.index;
//     _playing = player.state == FijkState.started;
//     _duration = player.value.duration;
//     _currentPos = player.currentPos;
//     _bufferPos = player.bufferPos;

//     _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
//       if (_hideStuff == false) {
//         setState(() {
//           _currentPos = v;
//         });
//       } else {
//         _currentPos = v;
//       }
//     });

//     _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
//       if (_hideStuff == false) {
//         setState(() {
//           _bufferPos = v;
//         });
//       } else {
//         _bufferPos = v;
//       }
//     });

//     player.addListener(_playerValueChanged);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _valController?.close();
//     _hideTimer?.cancel();
//     _statelessTimer?.cancel();
//     _snapshotTimer?.cancel();
//     _currentPosSubs?.cancel();
//     _bufferPosSubs?.cancel();
//     player.removeListener(_playerValueChanged);
//   }

//   double dura2double(Duration d) {
//     return d != null ? d.inMilliseconds.toDouble() : 0.0;
//   }

//   void _playerValueChanged() {
//     FijkValue value = player.value;

//     if (value.duration != _duration) {
//       if (_hideStuff == false) {
//         setState(() {
//           _duration = value.duration;
//         });
//       } else {
//         _duration = value.duration;
//       }
//     }
//     bool playing = (value.state == FijkState.started);
//     bool prepared = value.prepared;
//     if (playing != _playing ||
//         prepared != _prepared ||
//         value.state == FijkState.asyncPreparing) {
//       setState(() {
//         _playing = playing;
//         _prepared = prepared;
//       });
//     }
//   }

//   void _restartHideTimer() {
//     _hideTimer?.cancel();
//     _hideTimer = Timer(Duration(milliseconds: widget.hideDuration), () {
//       setState(() {
//         _hideStuff = true;
//       });
//     });
//   }

//   void onTapFun() {
//     if (_hideStuff == true) {
//       _restartHideTimer();
//     }
//     setState(() {
//       _hideStuff = !_hideStuff;
//     });
//   }

//   void playOrPause() {
//     if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
//       if (player.state == FijkState.started) {
//         player.pause();
//       } else {
//         player.start();
//       }
//     } else {
//       FijkLog.w("Invalid state ${player.state} ,can't perform play or pause");
//     }
//   }

//   void onDoubleTapFun() {
//     playOrPause();
//   }

//   void onVerticalDragStartFun(DragStartDetails d) {
//     if (d.localPosition.dx > panelWidth() / 2) {
//       // right, volume
//       _dragLeft = false;
//       FijkVolume.getVol().then((v) {
//         if (widget.data != null &&
//             !widget.data.contains("__fijkview_panel_init_volume")) {
//           widget.data.setValue("__fijkview_panel_init_volume", v);
//         }
//         setState(() {
//           _volume = v;
//           _valController.add(v);
//         });
//       });
//     } else {
//       // left, brightness
//       _dragLeft = true;
//       FijkPlugin.screenBrightness().then((v) {
//         if (widget.data != null &&
//             !widget.data.contains("__fijkview_panel_init_brightness")) {
//           widget.data.setValue("__fijkview_panel_init_brightness", v);
//         }
//         setState(() {
//           _brightness = v;
//           _valController.add(v);
//         });
//       });
//     }
//     _statelessTimer?.cancel();
//     _statelessTimer = Timer(const Duration(milliseconds: 2000), () {
//       setState(() {});
//     });
//   }

//   void onVerticalDragUpdateFun(DragUpdateDetails d) {
//     double delta = d.primaryDelta / panelHeight();
//     delta = -delta.clamp(-1.0, 1.0);
//     if (_dragLeft != null && _dragLeft == false) {
//       if (_volume != null) {
//         _volume += delta;
//         _volume = _volume.clamp(0.0, 1.0);
//         FijkVolume.setVol(_volume);
//         setState(() {
//           _valController.add(_volume);
//         });
//       }
//     } else if (_dragLeft != null && _dragLeft == true) {
//       if (_brightness != null) {
//         _brightness += delta;
//         _brightness = _brightness.clamp(0.0, 1.0);
//         FijkPlugin.setScreenBrightness(_brightness);
//         setState(() {
//           _valController.add(_brightness);
//         });
//       }
//     }
//   }

//   void onVerticalDragEndFun(DragEndDetails e) {
//     _volume = null;
//     _brightness = null;
//   }

//   Widget buildPlayButton(BuildContext context, double height) {
//     Icon icon = (player.state == FijkState.started)
//         ? Icon(Icons.pause)
//         : Icon(Icons.play_arrow);
//     bool fullScreen = player.value.fullScreen;
//     return IconButton(
//       padding: EdgeInsets.all(0),
//       iconSize: fullScreen ? height : height * 0.8,
//       color: Color(0xFFFFFFFF),
//       icon: icon,
//       onPressed: playOrPause,
//     );
//   }

//   Future<void> onRefresh() async {
//     String dataSource = player.dataSource;
//     await player.reset();
//     await player.setDataSource(dataSource, autoPlay: true);
//   }

//   Widget buildRefreshButton(BuildContext context, double height) {
//     bool fullScreen = player.value.fullScreen;
//     return IconButton(
//       padding: EdgeInsets.all(0),
//       iconSize: fullScreen ? height : height * 0.8,
//       color: Color(0xFFFFFFFF),
//       icon: Icon(Icons.refresh),
//       onPressed: onRefresh,
//     );
//   }

//   Widget buildFullScreenButton(BuildContext context, double height) {
//     Icon icon = player.value.fullScreen
//         ? Icon(Icons.fullscreen_exit)
//         : Icon(Icons.fullscreen);
//     bool fullScreen = player.value.fullScreen;
//     return IconButton(
//       padding: EdgeInsets.all(0),
//       iconSize: fullScreen ? height : height * 0.8,
//       color: Color(0xFFFFFFFF),
//       icon: icon,
//       onPressed: () {
//         player.value.fullScreen
//             ? player.exitFullScreen()
//             : player.enterFullScreen();
//       },
//     );
//   }

//   Widget buildTimeText(BuildContext context, double height) {
//     String text =
//         "${_duration2String(_currentPos)}" + "/${_duration2String(_duration)}";
//     return Text(text, style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)));
//   }

//   Widget buildSlider(BuildContext context) {
//     double duration = dura2double(_duration);

//     double currentValue = _seekPos > 0 ? _seekPos : dura2double(_currentPos);
//     currentValue = currentValue.clamp(0.0, duration);

//     double bufferPos = dura2double(_bufferPos);
//     bufferPos = bufferPos.clamp(0.0, duration);

//     return Padding(
//       padding: EdgeInsets.only(left: 3),
//       child: FijkSlider(
//         colors: sliderColors,
//         value: currentValue,
//         cacheValue: bufferPos,
//         min: 0.0,
//         max: duration,
//         onChanged: (v) {
//           _restartHideTimer();
//           setState(() {
//             _seekPos = v;
//           });
//         },
//         onChangeEnd: (v) {
//           setState(() {
//             player.seekTo(v.toInt());
//             _currentPos = Duration(milliseconds: _seekPos.toInt());
//             _seekPos = -1.0;
//           });
//         },
//       ),
//     );
//   }

//   //  顶部的导航返回按钮
//   Widget buildNaviBack(BuildContext context, double height) {
//     return Container(
// //      color: Colors.deepOrangeAccent,
//       child: IconButton(
//         padding: EdgeInsets.only(left: 26, right: 20),
//         icon: Icon(
//           Icons.arrow_back,
//           size: height,
//         ),
//         onPressed: () {
//           if (player.value.fullScreen) {
//             player.exitFullScreen();
//           }

//           // The delay fixes it
//           Future.delayed(Duration(milliseconds: 200)).then((_) {
//             Navigator.pop(context);
//           });
//         },
//       ),
//     );
//   }

//   // 文本样式
//   TextStyle _textStyle = TextStyle(fontSize: 16, color: Color(0xFFFFFFFF));
//   Widget buildNaviTitle(BuildContext context, double height) {
//     return Text(
//       widget.title,
//       style: _textStyle,
//     );
//   }

//   // Widget buildNaviCollect(BuildContext context, double height) {
//   //   return IconButton(
//   //     icon: Icon(_isFavorite
//   //           ? Icons.favorite
//   //           : Icons.favorite_border,

//   //     ),
//   //     onPressed: () {},
//   //   );
//   // }

//   Widget buildNaviMore(BuildContext context, double height) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 30,
//         right: 40,
//       ),
//       child: GestureDetector(
//         onTap: () {
//           Future.wait([
//             FijkVolume.getVol().then((v) {
//               return v;
//             }),
//             FijkPlugin.screenBrightness().then((v) {
//               return v;
//             })
//           ]).then((results) {
//             // showDialog(
//             //     context: context,
//             //     barrierDismissible: false,
//             //     builder: (BuildContext context) {
//             //       return SideBarPlayLight(
//             //         curVolume: results[0] ?? 0,
//             //         curLight: results[1] ?? 0,
//             //         onCloseEvent: () {
//             //           Navigator.pop(context, '1');
//             //         },
//             //         didChangeVolume: (double oldNum, double newNum) {
//             //           _volume = newNum;
//             //           FijkVolume.setVol(_volume);
//             //           print('haha=didChangeVolume-old:$oldNum,new:$newNum');
//             //         },
//             //         didChangeLight: (double oldNum, double newNum) {
//             //           _brightness = newNum;
//             //           FijkPlugin.setScreenBrightness(_brightness);
//             //           print('haha=didChangeLight-old:$oldNum,new:$newNum');
//             //         },
//             //       );
//             //     });
//           }).catchError((e) {
//             // showToast(e.toString());
//           });
//         },
//         child: Icon(
//           Icons.more_horiz,
//           size: height,
//         ),
//       ),
//     );
//   }

//   Widget buildBottom(BuildContext context, double height) {
//     if (_duration != null && _duration.inMilliseconds > 0) {
//       return Row(
//         children: <Widget>[
//           buildPlayButton(context, height),
//           buildRefreshButton(context, height),
//           buildTimeText(context, height),
//           Expanded(child: buildSlider(context)),
//           buildFullScreenButton(context, height),
//         ],
//       );
//     } else {
//       return Row(
//         children: <Widget>[
//           buildPlayButton(context, height),
//           buildRefreshButton(context, height),
//           Expanded(child: Container()),
//           DropdownButton(
//               hint: Text("清晰度"),
//               items: [
//                 DropdownMenuItem(
//                     child: Text(
//                       "720P",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     value: "720"),
//                 DropdownMenuItem(
//                   child: Text(
//                     "1080P",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   value: "1080",
//                 )
//               ],
//               value: "720",
//               style: _textStyle,
//               iconEnabledColor:Color(0xFFFFFFFF),
//               onChanged: (value) {
//                 print(value);
//                 setState(() {});
//               }),
//           buildFullScreenButton(context, height),
//         ],
//       );
//     }
//   }

//   Widget buildQnButton(BuildContext context, double height) {
//     bool fullScreen = player.value.fullScreen;
//     return IconButton(
//       padding: EdgeInsets.all(0),
//       iconSize: fullScreen ? height : height * 0.8,
//       color: Color(0xFFFFFFFF),
//       icon: Icon(Icons.refresh),
//       onPressed: onRefresh,
//     );
//   }

//   Widget buildTop(BuildContext context, double height) {
//     // if (_isLocked) {
//     //   // if locked, fixed screen and hidden all other controls
//     //   return Container();
//     // }

//     return Row(
//       children: <Widget>[
//         buildNaviBack(context, height),
//         buildNaviTitle(context, height),
//         Expanded(
//           child: Container(),
//         ),
//         // buildNaviCollect(context, height),
//         buildNaviMore(context, height),
//       ],
//     );
//   }

//   void takeSnapshot() {
//     player.takeSnapShot().then((v) {
//       var provider = MemoryImage(v);
//       precacheImage(provider, context).then((_) {
//         setState(() {
//           _imageProvider = provider;
//         });
//       });
//       FijkLog.d("get snapshot succeed");
//     }).catchError((e) {
//       FijkLog.d("get snapshot failed");
//     });
//   }

//   Widget buildPanel(BuildContext context) {
//     double height = panelHeight();

//     bool fullScreen = player.value.fullScreen;
//     Widget centerWidget = Container(
//       color: Color(0x00000000),
//     );

//     Widget centerChild = Container(
//       color: Color(0x00000000),
//     );

//     if (fullScreen && widget.snapShot) {
//       centerWidget = Row(
//         children: <Widget>[
//           Expanded(child: centerChild),
//           Padding(
//             padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 IconButton(
//                   padding: EdgeInsets.all(0),
//                   color: Color(0xFFFFFFFF),
//                   icon: Icon(Icons.camera_alt),
//                   onPressed: () {
//                     takeSnapshot();
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Container(
//           height: height > 200 ? 80 : height / 5,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0x88000000), Color(0x00000000)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         Expanded(
//           child: centerWidget,
//         ),
//         Container(
//           height: height > 80 ? 80 : height / 2,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0x88000000), Color(0x00000000)],
//               end: Alignment.topCenter,
//               begin: Alignment.bottomCenter,
//             ),
//           ),
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: height > 80 ? 45 : height / 2,
//             padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
//             child: buildBottom(context, height > 80 ? 40 : height / 2),
//           ),
//         )
//       ],
//     );
//   }

//   GestureDetector buildGestureDetector(BuildContext context) {
//     return GestureDetector(
//       onTap: onTapFun,
//       onDoubleTap: widget.doubleTap ? onDoubleTapFun : null,
//       onVerticalDragUpdate: onVerticalDragUpdateFun,
//       onVerticalDragStart: onVerticalDragStartFun,
//       onVerticalDragEnd: onVerticalDragEndFun,
//       onHorizontalDragUpdate: (d) {},
//       child: AbsorbPointer(
//         absorbing: _hideStuff,
//         child: AnimatedOpacity(
//           opacity: _hideStuff ? 0 : 1,
//           duration: Duration(milliseconds: 300),
//           child: buildPanel(context),
//         ),
//       ),
//     );
//   }

//   Rect panelRect() {
//     Rect rect = player.value.fullScreen || (true == widget.fill)
//         ? Rect.fromLTWH(0, 0, widget.viewSize.width, widget.viewSize.height)
//         : Rect.fromLTRB(
//             max(0.0, widget.texPos.left),
//             max(0.0, widget.texPos.top),
//             min(widget.viewSize.width, widget.texPos.right),
//             min(widget.viewSize.height, widget.texPos.bottom));
//     return rect;
//   }

//   double panelHeight() {
//     if (player.value.fullScreen || (true == widget.fill)) {
//       return widget.viewSize.height;
//     } else {
//       return min(widget.viewSize.height, widget.texPos.bottom) -
//           max(0.0, widget.texPos.top);
//     }
//   }

//   double panelWidth() {
//     if (player.value.fullScreen || (true == widget.fill)) {
//       return widget.viewSize.width;
//     } else {
//       return min(widget.viewSize.width, widget.texPos.right) -
//           max(0.0, widget.texPos.left);
//     }
//   }

//   Widget buildBack(BuildContext context) {
//     return IconButton(
//       padding: EdgeInsets.only(left: 5),
//       icon: Icon(
//         Icons.arrow_back_ios,
//         color: Color(0xDDFFFFFF),
//       ),
//       onPressed: widget.onBack,
//     );
//   }

//   Widget buildStateless() {
//     if (_volume != null || _brightness != null) {
//       Widget toast = _volume == null
//           ? defaultFijkBrightnessToast(_brightness, _valController.stream)
//           : defaultFijkVolumeToast(_volume, _valController.stream);
//       return IgnorePointer(
//         child: AnimatedOpacity(
//           opacity: 1,
//           duration: Duration(milliseconds: 500),
//           child: toast,
//         ),
//       );
//     } else if (player.state == FijkState.asyncPreparing) {
//       return Container(
//         alignment: Alignment.center,
//         child: SizedBox(
//           width: 30,
//           height: 30,
//           child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation(Colors.white)),
//         ),
//       );
//     } else if (player.state == FijkState.error) {
//       return Container(
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.error,
//           size: 30,
//           color: Color(0x99FFFFFF),
//         ),
//       );
//     } else if (_imageProvider != null) {
//       _snapshotTimer?.cancel();
//       _snapshotTimer = Timer(Duration(milliseconds: 1500), () {
//         if (mounted) {
//           setState(() {
//             _imageProvider = null;
//           });
//         }
//       });
//       return Center(
//         child: IgnorePointer(
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.yellowAccent, width: 3)),
//             child:
//                 Image(height: 200, fit: BoxFit.contain, image: _imageProvider),
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }

//   String _duration2String(Duration duration) {
//     if (duration.inMilliseconds < 0) return "-: negtive";

//     String twoDigits(int n) {
//       if (n >= 10) return "$n";
//       return "0$n";
//     }

//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     int inHours = duration.inHours;
//     return inHours > 0
//         ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
//         : "$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     Rect rect = panelRect();

//     List ws = <Widget>[];

//     if (_statelessTimer != null && _statelessTimer.isActive) {
//       ws.add(buildStateless());
//     } else if (player.state == FijkState.asyncPreparing) {
//       ws.add(buildStateless());
//     } else if (player.state == FijkState.error) {
//       ws.add(buildStateless());
//     } else if (_imageProvider != null) {
//       ws.add(buildStateless());
//     }
//     ws.add(buildGestureDetector(context));
//     if (widget.onBack != null) {
//       ws.add(buildBack(context));
//     }
//     return Positioned.fromRect(
//       rect: rect,
//       child: Stack(children: ws),
//     );
//   }
// }
