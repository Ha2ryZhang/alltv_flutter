import 'package:alltv/model/category.dart';
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
    );
  }

  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      print("正在刷新...");
    });
  }

  List<Widget> buildTabViewItem() {
    List<Widget> widgets = [];
    _categoryList.forEach((category) {
      var refreshIndicator = RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView(
            children: <Widget>[buildCardItem()],
          ));
      widgets.add(refreshIndicator);
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

  Widget buildCardItem() {
    return Card(
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.');
            },
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://rpic.douyucdn.cn/asrpic/200504/276685_1847.png/dy1',
                  fit: BoxFit.fitWidth,
                  width: 400,
                ),
                ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                          'https://apic.douyucdn.cn/upload/avatar_v3/202004/154c0d537ee14b8db3c6bcfceec117f2_big.jpg',
                          fit: BoxFit.fill,
                          width: 50,
                          height: 50)),
                  title: Text('斗鱼·黄金大奖赛'),
                  subtitle: Text('【黄金大奖赛S9】5.4E组17点'),
                ),
              ],
            )));
  }
}
