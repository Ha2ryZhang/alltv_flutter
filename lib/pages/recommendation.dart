import 'package:alltv/model/category.dart';
import 'package:alltv/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

/// 推荐页
class Recommendation extends StatefulWidget {
  @override
  RecommendationState createState() => new RecommendationState();
}

class RecommendationState extends State<Recommendation>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  // 用一个key来保存下拉刷新控件RefreshIndicator
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
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
      title: Text("首页推荐"),
      centerTitle: true,
      leading: new IconButton(
          icon: new Icon(Icons.live_tv),
          onPressed: () {
            Fluttertoast.showToast(
                msg: "This is Center Short Toast",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER);
          }),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      bottom: buildTabBar(),
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
    );
  }

  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      print("正在刷新...");
    });
  }

  /// tab view
  Widget buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        RefreshIndicator(
            key: _refreshKey,
            onRefresh: _onRefresh,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            )),
        Text('22222'),
        Text('33333'),
        Text('44444'),
      ],
    );
  }
}
