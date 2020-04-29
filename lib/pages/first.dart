import 'package:flutter/material.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstTabState createState() => new FirstTabState();
}

class FirstTabState extends State<FirstTab> with SingleTickerProviderStateMixin  {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      body: Container(),
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
        Tab(icon: Icon(Icons.email)),
        Tab(icon: Icon(Icons.accessibility)),
        Tab(icon: Icon(Icons.beach_access)),
      ],
      controller: _tabController,
    );
  }

  /// tab view
  Widget buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Text('11111'),
        Text('22222'),
        Text('33333'),
      ],
    );
  }
}
