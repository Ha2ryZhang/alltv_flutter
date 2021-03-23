import 'package:alltv/model/category.dart';
import 'package:flutter/material.dart';

/// 首页直播分类（自定义）
class CategoryList with ChangeNotifier {
  List<Category>? items;
  get categories => items;

  CategoryList({List<Category>? items});

  void setCategories(List<Category> items) {
    this.items = items;
    notifyListeners();
  }

  // factory CategoryList.fromJson(List<Map> json) {
  //   List<Category> list = [];
  //   json.forEach((f) {
  //     list.add(Category(
  //       cid: f["cid"],
  //       name: f["name"],
  //     ));
  //   });
  //   return list;
  // }
}
