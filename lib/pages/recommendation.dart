import 'package:alltv/model/category.dart';
import 'package:alltv/pages/live_room_list.dart';
import 'package:alltv/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 推荐页
class Recommendation extends StatefulWidget {
  final TabController controller;
  const Recommendation({Key key, this.controller}) : super(key: key);
  @override
  RecommendationState createState() => new RecommendationState();
}

class RecommendationState extends State<Recommendation>
    with SingleTickerProviderStateMixin {
  //推荐分类列表
  List<Category> _categoryList = [];

  @override
  void initState() {
    super.initState();
    _categoryList =
        Provider.of<CategoryList>(context, listen: false).categories;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildTabView(),
    );
  }


  /// tabbar
  Widget buildTabBar() {
    List<Widget> widgets = [];
    _categoryList.forEach((c) {
      widgets.add(Tab(text: c.name));
    });

    return TabBar(
        tabs: widgets,
        isScrollable: true,
        controller: widget.controller,
        indicatorColor: Colors.white);
  }

  List<Widget> buildTabViewItem() {
    List<Widget> widgets = [];
    _categoryList.forEach((category) {
      widgets.add(LiveList(
        cid: category.cid,
        com: 'all',
      ));
    });
    return widgets;
  }

  /// tab view
  Widget buildTabView() {
    return TabBarView(
      controller: widget.controller,
      children: buildTabViewItem(),
    );
  }
}
