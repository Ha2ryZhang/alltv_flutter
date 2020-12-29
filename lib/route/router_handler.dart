import 'package:alltv/model/live_room.dart';
import 'package:alltv/pages/chanel_detail.dart';
import 'package:alltv/pages/homePage.dart';
import 'package:alltv/pages/live_page.dart';
import 'package:alltv/pages/search.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/pages/theme_setting.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// 闪屏
Handler splashPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  },
);

// 正常路由跳转 homepage
Handler homePageHanderl =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  if (params.containsKey('index')) {
    return AllTVHome(index: int.parse(params["index"].first));
  }
  return AllTVHome();
});

// 路由传参
Handler livePageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  LiveRoom liveRoom = new LiveRoom();
  liveRoom.roomId = params['roomId'].first;
  liveRoom.com = params['com'].first;
  liveRoom.roomThumb = params['roomThumb'].first;
  liveRoom.avatar = params['avatar'].first;
  liveRoom.roomName = params['roomName'].first;
  liveRoom.ownerName = params['ownerName'].first;
  liveRoom.cateName = params['cateName'].first;
  return LivePage(room: liveRoom);
});
//主题设置
Handler themeSettingHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ThemeSetting();
});

Handler chanelDetailHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ChanelDetail(com: params['com'].first);
});
Handler searchHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPage();
});
// // 登陆页面
// Handler loginHanderl = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//         return Login();
//     }
// );
