import 'dart:io';

import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/utils/storage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 全局配置
class Global {
 
  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 自定义分类列表,
  static Category category = Category();


  /// init
  static Future init() async {
    // 运行初始
    WidgetsFlutterBinding.ensureInitialized();

    // 工具初始
    await StorageUtil.init();

    // 初始化路由
    Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  
    // 读取设备第一次打开
    isFirstOpen = !StorageUtil().getBool("device_already_open");
    if (isFirstOpen) {
      StorageUtil().setBool("device_already_open", true);
    }
    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // // 持久化 用户信息
  // static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
  //   profile = userResponse;
  //   return StorageUtil()
  //       .setJSON(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  // }
}
