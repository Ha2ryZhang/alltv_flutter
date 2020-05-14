import 'dart:io';

import 'package:alltv/model/category.dart';
import 'package:alltv/provider/provider.dart';
import 'package:alltv/route/Application.dart';
import 'package:alltv/route/routes.dart';
import 'package:alltv/utils/storage.dart';
import 'package:alltv/values/storages.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 全局配置
class Global {
  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 自定义分类列表,
  static CategoryList categories = new CategoryList();

  // 主题信息
  static ThemeInfo themeInfo = new ThemeInfo();

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
    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }
    //读取主题信息

    String themeColor = StorageUtil().getString(THEME_INFO);

    themeColor == null
        ? themeInfo.setTheme('blue')
        : themeInfo.setTheme(themeColor);

    //读取分类信息 没有的话给个默认值

    List _categoriesJSON = StorageUtil().getJSON(RECOMMENDATION_CATEGORY_LIST);

    if (_categoriesJSON != null) {
      //临时办法
      List<Category> clist = [];
      _categoriesJSON.forEach((f) {
        clist.add(Category.fromJson(f));
      });
      categories.setCategories(clist);
    } else {
      //设置默认分类 倒时候换成api 读取
      Category c1 = new Category(cid: '0', name: "推荐");
      Category c2 = new Category(cid: '181', name: "王者荣耀");
      Category c3 = new Category(cid: '1', name: "英雄联盟");
      Category c4 = new Category(cid: '270', name: "绝地求生");
      Category c5 = new Category(cid: '311', name: "颜值");
      List<Category> list = [];
      list.add(c1);
      list.add(c2);
      list.add(c3);
      list.add(c4);
      list.add(c5);
      categories.setCategories(list);
      //保存localstorage
      StorageUtil().setJSON(RECOMMENDATION_CATEGORY_LIST, list);
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
