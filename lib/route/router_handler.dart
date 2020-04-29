import 'package:alltv/pages/homePage.dart';
import 'package:alltv/pages/splash_page.dart';
import 'package:alltv/pages/test.dart';
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
    }
);

// 路由传参
Handler testHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        String title = params['title'].first;
        return TestPage(title: title);
    }
);

// // 登陆页面
// Handler loginHanderl = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//         return Login();
//     }
// );