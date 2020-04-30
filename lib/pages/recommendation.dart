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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        onPressed: () {},
      ),
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
    return TabBar(
      tabs: <Widget>[
        Tab(text: "推荐"),
        Tab(text: "王者荣耀"),
        Tab(text: "英雄联盟"),
        Tab(text: "绝地求生"),
        Tab(text: "娱乐天地")
      ],
      isScrollable: true,
      controller: _tabController,
    );
  }

  /// tab view
  Widget buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Center(
          child: MaterialButton(
            child: Text("sss+${Provider.of<Category>(context).name}"),
            onPressed: (){
             Provider.of<Category>(context,listen: false).changeName();
            },
          ),
        ),
        Text('22222'),
        Text('33333'),
        Text('44444'),
        Text('55555'),
      ],
    );
  }
}
