import 'package:alltv/pages/homePage.dart';
import 'package:alltv/pages/live_page.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// 闪屏
Handler splashPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  },
);

// 正常路由跳转 homepage
Handler homePageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AllTVHome();
});

// 路由传参
Handler livePageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String roomId = params['roomId'].first;
  String com = params['com'].first;
  return LivePage(roomId: roomId, com: com);
});

// // 登陆页面
// Handler loginHanderl = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//         return Login();
//     }
// );
