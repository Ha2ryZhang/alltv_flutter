import 'package:alltv/model/category.dart';
import 'package:alltv/pages/live_room_list.dart';
import 'package:alltv/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 推荐页
class Recommendation extends StatefulWidget {
  @override
  RecommendationState createState() => new RecommendationState();
}

class RecommendationState extends State<Recommendation>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  //推荐分类列表
  List<Category> _categoryList = [];

  @override
  void initState() {
    super.initState();
    _categoryList =
        Provider.of<CategoryList>(context, listen: false).categories;
    _tabController = TabController(length: _categoryList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildTabView(),
    );
  }

  /// appbar
  Widget buildAppBar() {
    return AppBar(
      title: buildTabBar(),
      titleSpacing: 0.0,
      // 暂时去掉
      // leading: new IconButton(
      //     icon: new Icon(Icons.live_tv),
      //     onPressed: () {
      //       Fluttertoast.showToast(
      //           msg: "This is Center Short Toast",
      //           toastLength: Toast.LENGTH_SHORT,
      //           gravity: ToastGravity.CENTER);
      //     }),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.arrow_drop_down),
          iconSize: 38.0,
          alignment: Alignment.bottomCenter,
          tooltip: "自定义",
          onPressed: () {},
        ),
      ],
      // bottom: buildTabBar(),
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
        controller: _tabController,
        indicatorColor: Colors.white);
  }

  List<Widget> buildTabViewItem() {
    List<Widget> widgets = [];
    _categoryList.forEach((category) {
      widgets.add(LiveList(cid: category.cid));
    });
    return widgets;
  }

  /// tab view
  Widget buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: buildTabViewItem(),
    );
  }
}
