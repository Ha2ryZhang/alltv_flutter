import 'package:flutter/material.dart';

/// 首页直播分类（自定义）
class Category with ChangeNotifier {
  String name;
  get categoryName => name;

  Category({String name = ""}) {
    this.name = name;
  }
  void changeName(){
    this.name="123456";
    notifyListeners();
  }
}
